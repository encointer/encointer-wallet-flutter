import 'dart:async';
import 'dart:convert';

import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_builder.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/connectivity/connectivity_store.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_log/ew_log.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/pallet_encointer_offline_payment/groth16_proof_bytes.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/substrate_fixed/fixed_u128.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';

const _logTarget = 'SettlementService';

late SettlementService settlementService;

/// Submits pending offline payments when connectivity is restored.
///
/// Activates only when `developerMode == true` AND `isConnectedToNetwork == true`.
/// Settles in chronological order (oldest first).
class SettlementService {
  SettlementService({
    required this.appStore,
    required this.connectivityStore,
    required this.appSettings,
  });

  final AppStore appStore;
  final ConnectivityStore connectivityStore;
  final AppSettings appSettings;

  ReactionDisposer? _disposer;
  bool _settling = false;

  /// Start listening for connectivity changes.
  void start() {
    _disposer = reaction(
      (_) => (connectivityStore.isConnectedToNetwork, appSettings.developerMode),
      (record) {
        final (isConnected, isDevMode) = record;
        if (isConnected && isDevMode) {
          settlePendingPayments();
        }
      },
      fireImmediately: true,
    );
    Log.d('Settlement listener started', _logTarget);
  }

  /// Stop the connectivity reaction.
  void dispose() {
    _disposer?.call();
    _disposer = null;
    Log.d('Settlement listener disposed', _logTarget);
  }

  Future<void> settlePendingPayments() async {
    if (_settling) return;
    _settling = true;

    try {
      final currentAddress = appStore.account.currentAddress;
      final unsettled = appStore.offlinePayment.unsettledPayments
          .where((p) => p.senderAddress == currentAddress || p.recipientAddress == currentAddress)
          .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      if (unsettled.isEmpty) {
        Log.d('No unsettled offline payments for current account', _logTarget);
        return;
      }

      Log.d('Settling ${unsettled.length} offline payments', _logTarget);

      for (final record in unsettled) {
        await _settleOne(record);
      }
    } finally {
      _settling = false;
    }
  }

  Future<void> _settleOne(OfflinePaymentRecord record) async {
    final api = webApi;
    final pubKey = appStore.account.currentAccountPubKey;
    if (pubKey == null) {
      Log.e('No current account, skipping settlement', _logTarget);
      return;
    }

    try {
      await appStore.offlinePayment.updateStatus(record.nullifierHex, OfflinePaymentStatus.submitted);

      final proofBytes = base64Decode(record.proofBase64);
      final cid = CommunityIdentifier.fromFmtString(record.cidFmt);

      final call = api.encointer.encointerKusama.tx.encointerOfflinePayment.submitOfflinePayment(
        proof: Groth16ProofBytes(proofBytes: proofBytes.toList()),
        sender: AddressUtils.addressToPubKey(record.senderAddress).toList(),
        recipient: AddressUtils.addressToPubKey(record.recipientAddress).toList(),
        amount: FixedU128(bits: i64F64Util.toFixed(record.amount)),
        cid: cid.toPolkadart(),
        nullifier: Fmt.hexToBytes(record.nullifierHex).toList(),
      );

      final signer = appStore.account.getKeyringAccount(pubKey);
      final xt = await TxBuilder(api.provider).createSignedExtrinsicWithEncodedCall(signer.pair, call.encode());
      final opaqueXt = OpaqueExtrinsic(xt);

      // 1. Wait for block inclusion
      final blockHash = await _submitAndWaitForBlock(opaqueXt);
      Log.d('Settlement xt in block $blockHash for ${record.nullifierHex}', _logTarget);

      // 2. Try to decode events to detect dispatch errors
      try {
        final report = await EWAuthorApi(api.provider).getExtrinsicReportData(opaqueXt, blockHash);
        if (report.isExtrinsicFailed) {
          final error = report.dispatchError.toString();
          Log.e('Settlement dispatch error for ${record.nullifierHex}: $error', _logTarget);
          // Only mark as permanently failed for proof-related errors (not retryable).
          // Everything else (nonce, balance, etc.) stays pending for retry.
          if (error.contains('InvalidProof') || error.contains('ProofDeserializationFailed')) {
            await appStore.offlinePayment.updateStatus(record.nullifierHex, OfflinePaymentStatus.failed);
          }
          return;
        }
      } on Exception catch (e) {
        Log.d('Could not decode events (dev node): $e — assuming success', _logTarget);
      }
      await appStore.offlinePayment.updateStatus(record.nullifierHex, OfflinePaymentStatus.confirmed);
    } catch (e, s) {
      // Transient errors (network, timeout) — keep as pending for retry
      Log.e('Settlement error for nullifier ${record.nullifierHex}: $e', _logTarget, s);
    }
  }

  /// Submit extrinsic and wait for block inclusion without decoding events.
  Future<String> _submitAndWaitForBlock(OpaqueExtrinsic xt) async {
    final completer = Completer<String>();

    final sub = await EWAuthorApi(webApi.provider).submitAndWatchExtrinsic(xt, (status) {
      Log.d('Settlement xt status: ${status.type}', _logTarget);
      if (status.type == 'inBlock' || status.type == 'finalized') {
        if (!completer.isCompleted) completer.complete(status.value.toString());
      }
    });

    sub
      ..onError((Object error) {
        if (!completer.isCompleted) completer.completeError(Exception('Subscription error: $error'));
      })
      ..onDone(() {
        if (!completer.isCompleted) completer.completeError(Exception('Subscription closed before inclusion'));
      });

    try {
      return await completer.future.timeout(extrinsicSubmissionTimeout);
    } finally {
      await sub.cancel();
    }
  }
}
