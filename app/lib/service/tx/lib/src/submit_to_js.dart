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
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';

/// Contains most of the logic from the `txConfirmPage.dart`, which was removed.

const insufficientFundsError = '1010';
const lowPriorityTx = '1014';

/// Inner function to submit a tx via the JS interface.
///
/// Should be private but dart lacks intelligent support to manage privacy. `submitTxWrappers/submitTx` should be
/// called from the outside instead of this one.
Future<void> submitToJS(
  BuildContext context,
  AppStore store,
  Api api,
  bool showStatusSnackBar, {
  required Map<String, dynamic> txParams,
  String? password,
  BigInt? tip,
}) async {
  final dic = context.l10n;

  store.assets.setSubmitting(true);
  store.account.setTxStatus(TxStatus.Queued);

  final txInfo = txParams['txInfo'] as Map<String, dynamic>;
  txInfo['pubKey'] = store.account.currentAccount.pubKey;
  txInfo['address'] = store.account.currentAddress;
  txInfo['password'] = password;
  txInfo['tip'] = tip.toString();
  Log.d('$txInfo', 'submitToJS');
  Log.d('${txParams['params']}', 'submitToJS');

  final onTxFinishFn = txParams['onFinish'] as dynamic Function(BuildContext, Map)?;

  if (await api.isConnected()) {
    if (showStatusSnackBar) {
      _showTxStatusSnackBar(
        getTxStatusTranslation(dic, store.account.txStatus),
        const CupertinoActivityIndicator(),
      );
    }

    final res = await api.account.sendTxAndShowNotification(
      txParams['txInfo'] as Map<String, dynamic>,
      txParams['params'] as List<dynamic>?,
      rawParam: txParams['rawParam'] as String?,
      cid: store.encointer.community?.cid.toFmtString(),
    );

    if (res['hash'] == null) {
      _onTxError(context, store, res['error'] as String, showStatusSnackBar);
    } else {
      _onTxFinish(context, store, res, onTxFinishFn!, showStatusSnackBar);
    }
  } else {
    _showTxStatusSnackBar(dic.txQueuedOffline, null);
    txInfo['notificationTitle'] = dic.notifySubmittedQueued;
    txInfo['txError'] = dic.txError;
    store.account.queueTx(txParams);
  }
}

void _onTxError(BuildContext context, AppStore store, String errorMsg, bool mounted) {
  store.assets.setSubmitting(false);
  if (mounted) RootSnackBar.removeCurrent();
  final dic = context.l10n;
  final languageCode = Localizations.localeOf(context).languageCode;

  final message = getLocalizedTxErrorMessage(dic, errorMsg);

  AppAlert.showDialog<void>(
    context,
    title: Text('${message['title']}'),
    content: Text('${message['body']}'),
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
        child: Text(dic.ok),
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
  Map res,
  void Function(BuildContext, Map) onTxFinish,
  bool mounted,
) {
  Log.d('callback triggered, blockHash: ${res['hash']}', '_onTxFinish');
  store.assets.setSubmitting(false);

  onTxFinish(context, res);

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

String getTxStatusTranslation(AppLocalizations dic, TxStatus? status) {
  if (status == null) return '';
  return switch (status) {
    TxStatus.Queued => dic.txQueued,
    TxStatus.QueuedOffline => dic.txQueuedOffline,
    TxStatus.Ready => dic.txReady,
    TxStatus.Broadcast => dic.txBroadcast,
    TxStatus.InBlock => dic.txInBlock,
    TxStatus.Error => dic.txError,
  };
}

Map<String, String> getLocalizedTxErrorMessage(AppLocalizations dic, String txError) {
  if (txError.startsWith(lowPriorityTx)) {
    return {'title': dic.txTooLowPriorityErrorTitle, 'body': dic.txTooLowPriorityErrorBody};
  } else if (txError.startsWith(insufficientFundsError)) {
    return {'title': dic.insufficientFundsErrorTitle, 'body': dic.insufficientFundsErrorBody};
  }

  return switch (txError) {
    'encointerCeremonies.VotesNotDependable' => {
        'title': dic.votesNotDependableErrorTitle,
        'body': dic.votesNotDependableErrorBody
      },
    'encointerCeremonies.AlreadyEndorsed' => {
        'title': dic.alreadyEndorsedErrorTitle,
        'body': dic.alreadyEndorsedErrorBody
      },
    'encointerCeremonies.NoValidClaims' => {
        'title': dic.noValidClaimsErrorTitle,
        'body': dic.noValidClaimsErrorBody,
      },
    'encointerCeremonies.RewardsAlreadyIssued' => {
        'title': dic.rewardsAlreadyIssuedErrorTitle,
        'body': dic.rewardsAlreadyIssuedErrorBody
      },
    'encointerBalances.BalanceTooLow' => {
        'title': dic.balanceTooLowTitle,
        'body': dic.balanceTooLowBody,
      },
    _ => {'title': dic.transactionError, 'body': txError},
  };
}
