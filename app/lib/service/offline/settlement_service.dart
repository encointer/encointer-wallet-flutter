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
      final pending = appStore.offlinePayment.pendingPayments
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      if (pending.isEmpty) {
        Log.d('No pending offline payments to settle', _logTarget);
        return;
      }

      Log.d('Settling ${pending.length} pending offline payments', _logTarget);

      for (final record in pending) {
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
      final report = await EWAuthorApi(api.provider).submitAndWatchExtrinsicWithReport(OpaqueExtrinsic(xt));

      if (report.isExtrinsicFailed) {
        Log.e('Settlement failed for nullifier ${record.nullifierHex}: ${report.dispatchError}', _logTarget);
        await appStore.offlinePayment.updateStatus(record.nullifierHex, OfflinePaymentStatus.failed);
      } else {
        Log.d('Settlement confirmed for nullifier ${record.nullifierHex}', _logTarget);
        await appStore.offlinePayment.updateStatus(record.nullifierHex, OfflinePaymentStatus.confirmed);
      }
    } catch (e, s) {
      Log.e('Settlement error for nullifier ${record.nullifierHex}: $e', _logTarget, s);
      await appStore.offlinePayment.updateStatus(record.nullifierHex, OfflinePaymentStatus.failed);
    }
  }
}
