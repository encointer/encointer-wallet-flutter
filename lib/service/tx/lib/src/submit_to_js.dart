import 'dart:core';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/tx_status.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/translations/translations_home.dart';
import 'package:encointer_wallet/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Contains most of the logic from the `txConfirmPage.dart`, which was removed.

const INSUFFICIENT_FUNDS_ERROR = '1010';

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
  final Translations dic = I18n.of(context)!.translationsForLocale();

  Map args = txParams;

  store.assets.setSubmitting(true);
  store.account.setTxStatus(TxStatus.Queued);

  Map txInfo = args['txInfo'];
  txInfo['pubKey'] = store.account.currentAccount.pubKey;
  txInfo['address'] = store.account.currentAddress;
  txInfo['password'] = password;
  txInfo['tip'] = tip.toString();
  // if (_proxyAccount != null) {
  //   txInfo['proxy'] = _proxyAccount.pubKey;
  //   txInfo['ss58'] = store.settings.endpoint.ss58.toString();
  // }
  print(txInfo);
  print(args['params']);

  var onTxFinishFn = (args['onFinish'] as Function(BuildContext, Map)?);

  if (await api.isConnected()) {
    if (showStatusSnackBar) {
      _showTxStatusSnackBar(
        getTxStatusTranslation(dic.home, store.account.txStatus),
        const CupertinoActivityIndicator(),
      );
    }

    final Map res = await _sendTx(context, api, args) as Map;

    if (res['hash'] == null) {
      _onTxError(context, store, res['error'], showStatusSnackBar);
    } else {
      _onTxFinish(context, store, res, onTxFinishFn!, showStatusSnackBar);
    }
  } else {
    _showTxStatusSnackBar(dic.home.txQueuedOffline, null);
    args['notificationTitle'] = dic.home.notifySubmittedQueued;
    store.account.queueTx(args as Map<String, dynamic>);
  }
}

Future<Map> getTxFee(
  AppStore store,
  Api api,
  Map args, {
  proxyAccount,
  bool reload = false,
}) async {
  Map txInfo = args['txInfo'];
  txInfo['pubKey'] = store.account.currentAccount.pubKey;
  txInfo['address'] = store.account.currentAddress;

  if (proxyAccount != null) {
    txInfo = proxyAccount.pubKey;
  }

  return api.account.estimateTxFees(txInfo, args['params'], rawParam: args['rawParam']);
}

void _onTxError(BuildContext context, AppStore store, String errorMsg, bool mounted) {
  store.assets.setSubmitting(false);
  if (mounted) {
    RootSnackBar.removeCurrent();
  }

  if (errorMsg.startsWith(INSUFFICIENT_FUNDS_ERROR)) {
    showInsufficientFundsDialog(context);
  } else {
    showErrorDialog(context, errorMsg);
  }
}

Future<dynamic> _sendTx(BuildContext context, Api api, Map args) async {
  return api.account.sendTxAndShowNotification(
    args['txInfo'],
    args['params'],
    args['title'],
    I18n.of(context)!.translationsForLocale().home.notifySubmitted,
    rawParam: args['rawParam'],
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

void _onTxFinish(BuildContext context, AppStore store, Map res, Function(BuildContext, Map) onTxFinish, bool mounted) {
  print('callback triggered, blockHash: ${res['hash']}');
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
      print('Illegal TxStatus supplied to translation: ${status.toString()}');
      return '';
  }
}

Future<void> showErrorDialog(BuildContext context, String errorMsg) {
  final Translations dic = I18n.of(context)!.translationsForLocale();

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
  final Translations dic = I18n.of(context)!.translationsForLocale();
  String languageCode = Localizations.localeOf(context).languageCode;

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
            onPressed: () => UI.launchURL(leuZurichLink(languageCode)),
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

// void _log(String msg) {
//   print("[txConfirmLogic] $msg");
// }
