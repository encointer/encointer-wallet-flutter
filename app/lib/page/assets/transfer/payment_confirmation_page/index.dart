import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/common/components/animation/animated_check.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/components/payment_overview.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/components/transfer_state.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/offline_payment.dart';
import 'package:encointer_wallet/service/offline/offline_identity_service.dart';
import 'package:encointer_wallet/store/connectivity/connectivity_store.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:ew_log/ew_log.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';
import 'package:ew_storage/ew_storage.dart';
import 'package:ew_substrate_fixed/substrate_fixed.dart';
import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:ew_zk_prover/ew_zk_prover.dart';

class PaymentConfirmationParams {
  const PaymentConfirmationParams({
    required this.cid,
    required this.communitySymbol,
    required this.recipientAccount,
    required this.amount,
  });

  final CommunityIdentifier cid;
  final String communitySymbol;
  final AccountData recipientAccount;
  final double amount;
}

class PaymentConfirmationPage extends StatefulWidget {
  const PaymentConfirmationPage(this.api, {super.key});

  static const String route = '/assets/paymentConfirmation';
  final Api api;

  @override
  State<PaymentConfirmationPage> createState() => _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  var _transferState = TransferState.notStarted;

  late final DateTime _blockTimestamp;
  String? _offlineQrPayload;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();
    final params = ModalRoute.of(context)!.settings.arguments! as PaymentConfirmationParams;
    final cid = params.cid;
    final recipientAccount = params.recipientAccount;
    final amount = params.amount;
    final recipientAddress = Address(
      pubkey: AddressUtils.pubKeyHexToPubKey(recipientAccount.pubKey),
      prefix: store.settings.currentNetwork.ss58(),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.payment)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            PaymentOverview(
              context.watch<AppStore>(),
              params.communitySymbol,
              params.recipientAccount,
              params.amount,
            ),
            const SizedBox(height: 10),
            Flexible(
              fit: FlexFit.tight,
              child: TextGradient(
                text: '${Fmt.doubleFormat(amount)} ⵐ',
                style: const TextStyle(fontSize: 60),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(turns: animation, child: child);
                },
                child: _getTransferStateWidget(_transferState),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: _txStateTextInfo(_transferState),
            ),
            if (!_transferState.isFinishedOrFailed()) ...[
              if (_shouldShowPayOffline(context))
                PrimaryButton(
                  onPressed: () => _submitOffline(context, cid, recipientAccount, amount),
                  child: const SizedBox(
                    height: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.wifi_square),
                        SizedBox(width: 12),
                        Text('Pay Offline'),
                      ],
                    ),
                  ),
                )
              else
                PrimaryButton(
                  key: const Key(EWTestKeys.makeTransferSend),
                  onPressed: () async => _submit(context, cid, recipientAddress, amount),
                  child: SizedBox(
                    height: 24,
                    child: !_transferState.isSubmitting()
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Iconsax.send_sqaure_2),
                              const SizedBox(width: 12),
                              Text(l10n.transfer),
                            ],
                          )
                        : const CupertinoActivityIndicator(),
                  ),
                ),
            ] else
              PrimaryButton(
                key: const Key(EWTestKeys.transferDone),
                child: SizedBox(height: 24, child: Center(child: Text(l10n.done))),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _submit(
    BuildContext context,
    CommunityIdentifier cid,
    Address recipientAddress,
    double amount,
  ) async {
    final authenticated = await context.read<LoginStore>().ensureAuthenticated(context);
    if (authenticated) {
      setState(() {
        _transferState = TransferState.submitting;
      });

      final store = context.read<AppStore>();
      await submitEncointerTransfer(
        context,
        store,
        widget.api,
        store.account.getKeyringAccount(store.account.currentAccountPubKey!),
        cid,
        recipientAddress,
        amount,
        txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
        onFinish: onFinish,
        onError: onError,
      );

      Log.d('TransferState after callback: $_transferState', 'PaymentConfirmationPage');
      // trigger rebuild after state update in callback
      setState(() {});
    } else {
      RootSnackBar.showMsg(context.l10n.authenticationNeeded);
    }
  }

  void onFinish(BuildContext txPageContext, ExtrinsicReport report) {
    Log.d('Transfer result $report', 'PaymentConfirmationPage');
    _blockTimestamp = DateTime.fromMillisecondsSinceEpoch(report.timestamp.toInt());
    _transferState = TransferState.finished;
  }

  void onError(DispatchError error) {
    Log.d('Error sending transfer $error', 'PaymentConfirmationPage');
    _transferState = TransferState.failed;
  }

  bool _shouldShowPayOffline(BuildContext context) {
    final appSettings = context.read<AppSettings>();
    final connectivity = context.read<ConnectivityStore>();
    return appSettings.developerMode && !connectivity.isConnectedToNetwork;
  }

  Future<void> _submitOffline(
    BuildContext context,
    CommunityIdentifier cid,
    AccountData recipientAccount,
    double amount,
  ) async {
    final authenticated = await context.read<LoginStore>().ensureAuthenticated(context);
    if (!authenticated) {
      RootSnackBar.showMsg(context.l10n.authenticationNeeded);
      return;
    }

    setState(() => _transferState = TransferState.submitting);

    try {
      final store = context.read<AppStore>();
      final pubKey = store.account.currentAccountPubKey!;
      final offlineIdService = OfflineIdentityService(const SecureStorage());

      // 1. Load zk_secret
      final zkSecret = await offlineIdService.loadZkSecret(pubKey);
      if (zkSecret == null) {
        throw StateError('Offline identity not registered. Register in Profile first.');
      }

      // 2. Generate random 32-byte nonce
      final nonce = Uint8List(32);
      final random = Random.secure();
      for (var i = 0; i < 32; i++) {
        nonce[i] = random.nextInt(256);
      }

      // 3. Recipient bytes (raw 32-byte pubkey)
      final recipientBytes = AddressUtils.pubKeyHexToPubKey(recipientAccount.pubKey);

      // 4. Amount as 32-byte LE (FixedU128 u128 bits in first 16 bytes)
      final amountBytes = _balanceToBytes32(amount);

      // 5. Compute chain_asset_hash = blake2_256(asset_hash ++ genesis_hash)
      //    for cross-chain replay protection (pallets PR #444)
      final assetHash = ZkProver.blake2_256(Uint8List.fromList(cid.toPolkadart().encode()));
      final genesisHash = await offlineIdService.loadGenesisHash(pubKey);
      if (genesisHash == null) {
        throw StateError('Genesis hash not stored. Re-register offline identity.');
      }
      final chainAssetHash = ZkProver.blake2_256(
        Uint8List.fromList([...assetHash, ...genesisHash]),
      );

      // 6. Generate ZK proof
      final provingKey = await offlineIdService.loadProvingKey();
      final result = await ZkProver.generateProof(ProofInput(
        provingKey: provingKey,
        zkSecret: zkSecret,
        nonce: nonce,
        recipientHash: recipientBytes,
        amount: amountBytes,
        assetHash: chainAssetHash,
      ));

      // 7. Build QR code
      final prefix = store.settings.currentNetwork.ss58();
      final senderAddress = AddressUtils.pubKeyHexToAddress(pubKey, prefix: prefix);
      final recipientAddress = AddressUtils.pubKeyHexToAddress(recipientAccount.pubKey, prefix: prefix);

      final qrCode = OfflinePaymentQrCode(
        proofBase64: base64Encode(result.proofBytes),
        sender: senderAddress,
        recipient: recipientAddress,
        cidFmt: cid.toFmtString(),
        network: store.settings.currentNetwork.id(),
        amount: amount.toString(),
        nullifierHex: Fmt.bytesToHex(result.nullifier),
        commitmentHex: Fmt.bytesToHex(result.commitment),
        reputationCount: store.encointer.account?.reputations.length ?? 0,
        label: store.account.currentAccount.name,
      );

      // 8. Save record
      await store.offlinePayment.addPayment(OfflinePaymentRecord(
        proofBase64: base64Encode(result.proofBytes),
        senderAddress: senderAddress,
        recipientAddress: recipientAddress,
        cidFmt: cid.toFmtString(),
        amount: amount,
        nullifierHex: Fmt.bytesToHex(result.nullifier),
        commitmentHex: Fmt.bytesToHex(result.commitment),
        role: OfflinePaymentRole.sender,
        createdAt: DateTime.now(),
      ));

      // 9. Show QR
      _offlineQrPayload = qrCode.toQrPayload();
      _transferState = TransferState.offlineQrReady;
      setState(() {});
    } catch (e, s) {
      Log.e('Offline payment error: $e', 'PaymentConfirmationPage', s);
      _transferState = TransferState.failed;
      setState(() {});
    }
  }

  /// Convert amount to 32-byte LE array matching pallet's `balance_to_bytes`.
  static Uint8List _balanceToBytes32(double amount) {
    final bits = i64F64Util.toFixed(amount);
    final bytes = Uint8List(32);
    var v = bits;
    for (var i = 0; i < 16; i++) {
      bytes[i] = (v & BigInt.from(0xFF)).toInt();
      v >>= 8;
    }
    return bytes;
  }

  Widget _getTransferStateWidget(TransferState state) {
    switch (state) {
      case TransferState.notStarted:
        return const SizedBox.shrink();
      case TransferState.submitting:
        return const SizedBox(height: 80, width: 80, child: CircularProgressIndicator());
      case TransferState.finished:
        return DecoratedBox(
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
          child: AnimatedCheck(animate: !RepositoryProvider.of<AppConfig>(context).isIntegrationTest),
        );
      case TransferState.failed:
        return const DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.highlight_remove, size: 80, color: Colors.white),
          ),
        );
      case TransferState.offlineQrReady:
        return SizedBox(
          width: 200,
          height: 200,
          child: PrettyQrView.data(data: _offlineQrPayload!),
        );
    }
  }

  Widget _txStateTextInfo(TransferState state) {
    final h1Grey = context.displayLarge.copyWith(color: AppColors.encointerGrey);
    final h2Grey = context.headlineSmall.copyWith(color: AppColors.encointerGrey);

    final l10n = context.l10n;

    switch (state) {
      case TransferState.notStarted:
        return Text(l10n.paymentDoYouWantToProceed, style: h2Grey);
      case TransferState.submitting:
        return Text(l10n.paymentSubmitting, style: h2Grey);
      case TransferState.finished:
        final date = DateFormat.yMd().format(_blockTimestamp);
        final time = DateFormat.Hms().format(_blockTimestamp);
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${l10n.paymentFinished}: $date\n\n',
            style: h2Grey,
            children: [TextSpan(text: time, style: h1Grey)],
          ),
        );
      case TransferState.failed:
        return Text(
          l10n.paymentError,
          style: h2Grey,
        );
      case TransferState.offlineQrReady:
        return Text('Show this QR code to the seller', style: h2Grey);
    }
  }
}
