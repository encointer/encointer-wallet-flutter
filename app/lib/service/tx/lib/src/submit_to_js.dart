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
  void Function(dynamic res)? onError,
  required String password,
  BigInt? tip,
}) async {
  final l10n = context.l10n;

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
        getTxStatusTranslation(l10n, store.account.txStatus),
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
      _onTxError(context, store, res['error'] as String, showStatusSnackBar, onError: onError);
    } else {
      _onTxFinish(context, store, res, onTxFinishFn!, showStatusSnackBar);
    }
  } else {
    _showTxStatusSnackBar(l10n.txQueuedOffline, null);
    txInfo['notificationTitle'] = l10n.notifySubmittedQueued;
    txInfo['txError'] = l10n.txError;
    store.account.queueTx(txParams);
  }
}

void _onTxError(
  BuildContext context,
  AppStore store,
  String errorMsg,
  bool mounted, {
  void Function(dynamic res)? onError,
}) {
  store.assets.setSubmitting(false);
  if (mounted) RootSnackBar.removeCurrent();
  final l10n = context.l10n;
  final languageCode = Localizations.localeOf(context).languageCode;
  final message = getLocalizedTxErrorMessage(l10n, errorMsg);

  onError?.call(errorMsg);

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

Map<String, String> getLocalizedTxErrorMessage(AppLocalizations l10n, String txError) {
  if (txError.startsWith(lowPriorityTx)) {
    return {'title': l10n.txTooLowPriorityErrorTitle, 'body': l10n.txTooLowPriorityErrorBody};
  } else if (txError.startsWith(insufficientFundsError)) {
    return {'title': l10n.insufficientFundsErrorTitle, 'body': l10n.insufficientFundsErrorBody};
  }

  return switch (txError) {
    'encointerCeremonies.VotesNotDependable' => {
        'title': l10n.votesNotDependableErrorTitle,
        'body': l10n.votesNotDependableErrorBody
      },
    'encointerCeremonies.AlreadyEndorsed' => {
        'title': l10n.alreadyEndorsedErrorTitle,
        'body': l10n.alreadyEndorsedErrorBody
      },
    'encointerCeremonies.NoValidClaims' => {
        'title': l10n.noValidClaimsErrorTitle,
        'body': l10n.noValidClaimsErrorBody,
      },
    'encointerCeremonies.RewardsAlreadyIssued' => {
        'title': l10n.rewardsAlreadyIssuedErrorTitle,
        'body': l10n.rewardsAlreadyIssuedErrorBody
      },
    'encointerBalances.BalanceTooLow' => {
        'title': l10n.balanceTooLowTitle,
        'body': l10n.balanceTooLowBody,
      },
    _ => {'title': l10n.transactionError, 'body': txError},
  };
}
