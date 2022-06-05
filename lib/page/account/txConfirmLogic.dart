import 'dart:core';

import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/txStatus.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/translations/translationsHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> onSubmit(BuildContext context, AppStore store, Api api, bool mounted,
    {String password, bool viaQr = false, BigInt tip}) async {
  final Translations dic = I18n.of(context).translationsForLocale();
  final Map args = ModalRoute.of(context).settings.arguments;

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

  var onTxFinishFn = (args['onFinish'] as Function(BuildContext, Map));

  if (await api.isConnected()) {
    _showTxStatusSnackBar(
      context,
      getTxStatusTranslation(dic.home, store.account.txStatus),
      CupertinoActivityIndicator(),
    ); // TODO armin, fix transfer status logic

    final Map res = await _sendTx(context, api, args);

    if (res['hash'] == null) {
      _onTxError(context, store, res['error'], mounted);
    } else {
      _onTxFinish(context, store, res, onTxFinishFn, mounted);
    }
  } else {
    _showTxStatusSnackBar(context, dic.home.txQueuedOffline, null);
    args['notificationTitle'] = I18n.of(context).translationsForLocale().home.notifySubmittedQueued;
    store.account.queueTx(args);
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

  return webApi.account.estimateTxFees(txInfo, args['params'], rawParam: args['rawParam']);
}

void _onTxError(BuildContext context, AppStore store, String errorMsg, bool mounted) {
  final Translations dic = I18n.of(context).translationsForLocale();
  store.assets.setSubmitting(false);
  if (mounted) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Container(),
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

Future<Map> _sendTx(BuildContext context, Api api, Map args) async {
  return api.account.sendTx(
    args['txInfo'],
    args['params'],
    args['title'],
    I18n.of(context).translationsForLocale().home.notifySubmitted,
    rawParam: args['rawParam'],
  );
}

void _showTxStatusSnackBar(BuildContext context, String status, Widget leading) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Theme.of(context).cardColor,
    content: ListTile(
      leading: leading,
      title: Text(
        status,
        style: TextStyle(color: Colors.black54),
      ),
    ),
    duration: Duration(seconds: 12),
  ));
}

void _onTxFinish(BuildContext context, AppStore store, Map res, Function(BuildContext, Map) onTxFinish, bool mounted) {
  print('callback triggered, blockHash: ${res['hash']}');
  store.assets.setSubmitting(false);

  onTxFinish(context, res);

  if (mounted) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: ListTile(
        leading: Container(
          width: 24,
          child: Image.asset('assets/images/assets/success.png'),
        ),
        title: Text(
          I18n.of(context).translationsForLocale().assets.success,
          style: TextStyle(color: Colors.black54),
        ),
      ),
      duration: Duration(seconds: 2),
    ));
  }
}

String getTxStatusTranslation(TranslationsHome dic, TxStatus status) {
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
      print("Illegal TxStatus supplied to translation: ${status.toString()}");
      return "";
  }
}
