import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/l10.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:ew_polkadart/generated/encointer_kusama/types/sp_runtime/dispatch_error.dart';

/// Contains most of the logic from the `txConfirmPage.dart`, which was removed.

/// Invalid transaction can be many things, but the most common are:
/// * Wrong Signed Extension
/// * BoundedVec out of bounds
const invalidTransactionFormat = '1002';
const insufficientFundsError = '1010';
const lowPriorityTx = '1014';

/// Inner function to submit a tx handling all the notifications.
Future<void> submitTxInner(
  BuildContext context,
  AppStore store,
  Api api,
  OpaqueExtrinsic extrinsic,
  TxNotification? notification, {
  void Function(DispatchError error)? onError,
  dynamic Function(BuildContext, ExtrinsicReport)? onFinish,
}) async {
  final l10n = context.l10n;

  store.assets.setSubmitting(true);
  store.account.setTxStatus(TxStatus.Queued);

  final onTxFinishFn = onFinish ?? (_, __) => null;

  if (await api.isConnected()) {
    try {
      final report = await api.account.sendTxAndShowNotification(
        extrinsic,
        notification,
        cid: store.encointer.community?.cid.toFmtString(),
      );

      if (report.isExtrinsicFailed) {
        Log.e('[TX] Extrinsic Failed: ${report.dispatchError!.toJson()}');
        _onTxError(store);
        onError?.call(report.dispatchError!);
      } else {
        _onTxFinish(context, store, report, onTxFinishFn);
      }
    } catch (e) {
      Log.e('Caught RPC error while sending extrinsics: $e');
      _onTxError(store);
      var msg = ErrorNotificationMsg(title: l10n.transactionError, body: e.toString());
      if (e.toString().contains(lowPriorityTx)) {
        msg = ErrorNotificationMsg(title: l10n.txTooLowPriorityErrorTitle, body: l10n.txTooLowPriorityErrorBody);
        showTxErrorDialog(context, msg, false);
      } else if (e.toString().contains(insufficientFundsError)) {
        msg = ErrorNotificationMsg(title: l10n.insufficientFundsErrorTitle, body: l10n.insufficientFundsErrorBody);
        showTxErrorDialog(context, msg, false);
      } else if (e.toString().contains(invalidTransactionFormat)) {
        msg = ErrorNotificationMsg(
            title: l10n.invalidTransactionFormatErrorTitle, body: l10n.invalidTransactionFormatErrorBody);
        showTxErrorDialog(context, msg, true);
      } else {
        showTxErrorDialog(context, msg, false);
      }
    }
  } else {
    _showTxStatusSnackBar(l10n.txQueuedOffline, null);
    // This was unused
    // txInfo['notificationTitle'] = l10n.notifySubmittedQueued;
    // txInfo['txError'] = l10n.txError;

    // Todo: check when rest of the implementation is finished,
    //  or maybe remove as it might not be working anyhow.
    // store.account.queueTx(txParams);
  }
}

void _onTxError(AppStore store) {
  store.assets.setSubmitting(false);
}

void showTxErrorDialog(BuildContext context, ErrorNotificationMsg message, bool showBugReportButton) {
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
      if (showBugReportButton)
        CupertinoButton(
          child: const Text('Bug Report'),
          onPressed: () => AppLaunch.sendEmail(
            bugReportMail,
            snackBarText: context.l10n.checkEmailApp,
            context: context,
          ),
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
) {
  Log.d('callback triggered, blockHash: ${report.blockHash}', '_onTxFinish');
  store.assets.setSubmitting(false);

  onTxFinish(context, report);
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
