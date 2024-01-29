import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';

/// Contains most of the logic from the `txConfirmPage.dart`, which was removed.

const insufficientFundsError = '1010';
const lowPriorityTx = '1014';

/// Inner function to submit a tx handling all the notifications.
Future<void> submitTxInner(
  BuildContext context,
  AppStore store,
  Api api,
  bool showStatusSnackBar, {
  required Map<String, dynamic> txParams,
  void Function(DispatchError error)? onError,
  required String password,
}) async {
  final l10n = context.l10n;

  store.assets.setSubmitting(true);
  store.account.setTxStatus(TxStatus.Queued);

  final txInfo = txParams['txInfo'] as Map<String, dynamic>;
  txInfo['pubKey'] = store.account.currentAccount.pubKey;
  txInfo['address'] = store.account.currentAddress;
  txInfo['password'] = password;
  Log.d('$txInfo', 'submitToJS');
  Log.d('${txParams['params']}', 'submitToJS');

  final onTxFinishFn = txParams['onFinish'] != null
      ? txParams['onFinish'] as dynamic Function(BuildContext, ExtrinsicReport)
      : (_, __) => null;

  if (await api.isConnected()) {
    if (showStatusSnackBar) {
      _showTxStatusSnackBar(
        getTxStatusTranslation(l10n, store.account.txStatus),
        const CupertinoActivityIndicator(),
      );
    }

    try {
      final report = await api.account.sendTxAndShowNotification(
        txParams['txInfo'] as Map<String, dynamic>,
        txParams['params'] as List<dynamic>?,
        rawParam: txParams['rawParam'] as String?,
        cid: store.encointer.community?.cid.toFmtString(),
      );

      if (report.isExtrinsicFailed) {
        _onTxError(store, showStatusSnackBar);
        onError?.call(report.dispatchError!);
        final message = getLocalizedTxErrorMessage(l10n, report.dispatchError!);
        _showErrorDialog(context, message);
      } else {
        _onTxFinish(context, store, report, onTxFinishFn, showStatusSnackBar);
      }
    } catch (e) {
      Log.e('Caught RPC error while sending extrinsics: $e');
      _onTxError(store, showStatusSnackBar);
      var msg = ErrorNotificationMsg(title: l10n.transactionError, body: e.toString());
      if (e.toString().contains(lowPriorityTx)) {
        msg = ErrorNotificationMsg(title: l10n.txTooLowPriorityErrorTitle, body: l10n.txTooLowPriorityErrorBody);
      } else if (e.toString().contains(insufficientFundsError)) {
        msg = ErrorNotificationMsg(title: l10n.insufficientFundsErrorTitle, body: l10n.insufficientFundsErrorBody);
      }
      _showErrorDialog(context, msg);
    }
  } else {
    _showTxStatusSnackBar(l10n.txQueuedOffline, null);
    txInfo['notificationTitle'] = l10n.notifySubmittedQueued;
    txInfo['txError'] = l10n.txError;
    store.account.queueTx(txParams);
  }
}

void _onTxError(AppStore store, bool mounted) {
  store.assets.setSubmitting(false);
  if (mounted) RootSnackBar.removeCurrent();
}

void _showErrorDialog(BuildContext context, ErrorNotificationMsg message) {
  final l10n = context.l10n;
  final languageCode = Localizations.localeOf(context).languageCode;

  AppAlert.showDialog<void>(
    context,
    title: Text(message.title),
    content: Text(message.body),
    actions: [
      const SizedBox.shrink(),
      CupertinoButton(
        child: const Text('FAQ'),
        onPressed: () {
          final cid = context.read<AppStore>().encointer.community?.cid.toFmtString();
          AppLaunch.launchURL(ceremonyInfoLink(languageCode, cid));
        },
      ),
      CupertinoButton(
        child: Text(l10n.ok),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}

void _showTxStatusSnackBar(String status, Widget? leading) {
  RootSnackBar.show(
    ListTile(
      leading: leading,
      title: Text(
        status,
        style: const TextStyle(color: Colors.black54),
      ),
    ),
    durationMillis: const Duration(seconds: 12).inMilliseconds,
  );
}

void _onTxFinish(
  BuildContext context,
  AppStore store,
  ExtrinsicReport report,
  void Function(BuildContext, ExtrinsicReport) onTxFinish,
  bool mounted,
) {
  Log.d('callback triggered, blockHash: ${report.blockHash}', '_onTxFinish');
  store.assets.setSubmitting(false);

  onTxFinish(context, report);

  if (mounted) {
    RootSnackBar.show(
      ListTile(
        leading: SizedBox(
          width: 24,
          child: Assets.images.assets.success.image(),
        ),
        title: Text(
          context.l10n.success,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
      durationMillis: 2000,
    );
  }
}

String getTxStatusTranslation(AppLocalizations l10n, TxStatus? status) {
  if (status == null) return '';
  return switch (status) {
    TxStatus.Queued => l10n.txQueued,
    TxStatus.QueuedOffline => l10n.txQueuedOffline,
    TxStatus.Ready => l10n.txReady,
    TxStatus.Broadcast => l10n.txBroadcast,
    TxStatus.InBlock => l10n.txInBlock,
    TxStatus.Error => l10n.txError,
  };
}
