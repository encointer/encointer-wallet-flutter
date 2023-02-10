import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/launch/app_launch.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations_home.dart';

/// Contains most of the logic from the `txConfirmPage.dart`, which was removed.

const insufficientFundsError = '1010';

/// Inner function to submit a tx via the JS interface.
///
/// Should be private but dart lacks intelligent support to manage privacy. `submitTxWrappers/submitTx` should be
/// called from the outside instead of this one.
Future<void> submitToJS(
  BuildContext context,
  AppStore store,
  Api api,
  bool showStatusSnackBar, {
  required Map txParams,
  String? password,
  BigInt? tip,
}) async {
  final dic = I18n.of(context)!.translationsForLocale();

  final args = txParams;

  store.assets.setSubmitting(true);
  store.account.setTxStatus(TxStatus.Queued);

  final txInfo = args['txInfo'] as Map;
  txInfo['pubKey'] = store.account.currentAccount.pubKey;
  txInfo['address'] = store.account.currentAddress;
  txInfo['password'] = password;
  txInfo['tip'] = tip.toString();
  Log.d('$txInfo', 'submitToJS');
  Log.d('${args['params']}', 'submitToJS');

  final onTxFinishFn = args['onFinish'] as dynamic Function(BuildContext, Map)?;

  if (await api.isConnected()) {
    if (showStatusSnackBar) {
      _showTxStatusSnackBar(
        getTxStatusTranslation(dic.home, store.account.txStatus),
        const CupertinoActivityIndicator(),
      );
    }
    if (context.mounted) return;
    final res = await _sendTx(context, api, args) as Map;

    if (res['hash'] == null && context.mounted) {
      _onTxError(context, store, res['error'] as String, showStatusSnackBar);
    } else {
      _onTxFinish(context, store, res, onTxFinishFn!, showStatusSnackBar);
    }
  } else {
    _showTxStatusSnackBar(dic.home.txQueuedOffline, null);
    args['notificationTitle'] = dic.home.notifySubmittedQueued;
    store.account.queueTx(args as Map<String, dynamic>);
  }
}

void _onTxError(BuildContext context, AppStore store, String errorMsg, bool mounted) {
  store.assets.setSubmitting(false);
  if (mounted) {
    RootSnackBar.removeCurrent();
  }

  if (errorMsg.startsWith(insufficientFundsError)) {
    showInsufficientFundsDialog(context);
  } else {
    showErrorDialog(context, errorMsg);
  }
}

Future<dynamic> _sendTx(BuildContext context, Api api, Map args) async {
  return api.account.sendTxAndShowNotification(
    args['txInfo'] as Map<dynamic, dynamic>?,
    args['params'] as List<dynamic>?,
    args['title'] as String?,
    I18n.of(context)!.translationsForLocale().home.notifySubmitted,
    rawParam: args['rawParam'] as String?,
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
        leading: SizedBox(width: 24, child: Image.asset('assets/images/assets/success.png')),
        title: Text(
          I18n.of(context)!.translationsForLocale().assets.success,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
      durationMillis: 2000,
    );
  }
}

String getTxStatusTranslation(TranslationsHome dic, TxStatus? status) {
  switch (status) {
    case TxStatus.Queued:
      return dic.txQueued;
    case TxStatus.QueuedOffline:
      return dic.txQueuedOffline;
    case TxStatus.Ready:
      return dic.txReady;
    case TxStatus.Broadcast:
      return dic.txBroadcast;
    case TxStatus.InBlock:
      return dic.txInBlock;
    case TxStatus.Error:
      return dic.txError;
    default:
      Log.d('Illegal TxStatus supplied to translation: $status', 'getTxStatusTranslation');
      return '';
  }
}

Future<void> showErrorDialog(BuildContext context, String errorMsg) {
  final dic = I18n.of(context)!.translationsForLocale();

  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(dic.assets.transactionError),
        content: Text(errorMsg),
        actions: <Widget>[
          CupertinoButton(
            child: Text(dic.home.ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

Future<void> showInsufficientFundsDialog(BuildContext context) {
  final dic = I18n.of(context)!.translationsForLocale();
  final languageCode = Localizations.localeOf(context).languageCode;

  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(dic.assets.transactionError),
        content: Text(dic.assets.insufficientFundsExplanation),
        actions: <Widget>[
          Container(),
          CupertinoButton(
            child: Text(dic.encointer.goToLeuZurich),
            onPressed: () => AppLaunch.launchURL(leuZurichLink(languageCode)),
          ),
          CupertinoButton(
            child: Text(dic.home.ok),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
