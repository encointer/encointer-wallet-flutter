import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/service/tx/lib/src/tx_notification.dart';
import 'package:encointer_wallet/service/tx/lib/src/send_tx_dart.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_polkadart/ew_polkadart.dart' show Provider;

class AccountApi {
  AccountApi(this.store, this.jsApi, this.provider);

  final JSApi jsApi;
  final Provider provider;
  final AppStore store;
  void Function()? fetchAccountData;

  Future<void> initAccounts() async {
    for (final account in store.account.keyring.accountsIter) {
      Log.d('[initAccounts]: ${account.toAccountData()}');
      await webApi.account.importAccount(
        key: account.uri,
        password: '',
        keyType: account.seedType.name,
      );
    }
  }

  void setFetchAccountData(void Function()? fetchAccountData) {
    this.fetchAccountData = fetchAccountData;
  }

  Future<void> changeCurrentAccount({
    String? pubKey,
    bool fetchData = false,
  }) async {
    var current = pubKey;
    if (pubKey == null) {
      if (store.account.accountListAll.isNotEmpty) {
        current = store.account.accountListAll[0].pubKey;
      } else {
        current = '';
      }
    }
    await store.setCurrentAccount(current);

    await store.loadAccountCache();
    if (fetchData) fetchAccountData?.call();
  }

  Future<ExtrinsicReport> sendTxAndShowNotification(
    OpaqueExtrinsic xt,
    TxNotification? notification, {
    String? cid,
  }) async {
    final report = await EWAuthorApi(provider).submitAndWatchExtrinsicWithReport(xt);

    if (report.isExtrinsicSuccess && notification != null) {
      final hash = report.blockHash;
      unawaited(NotificationPlugin.showNotification(
        int.parse(hash.substring(0, 6)),
        notification.title,
        notification.body,
        cid: cid,
      ));
    }
    return report;
  }

  Future<Map<String, dynamic>> getSignedTx(Map txInfo, List? params, {String? rawParam}) async {
    final param = rawParam ?? jsonEncode(params);
    final call = 'account.getXt(${jsonEncode(txInfo)}, $param)';
    Log.d('sendTx call: $call', 'AccountApi');
    return jsApi.evalJavascript<Map<String, dynamic>>(call);
  }

  Future<Map<String, dynamic>> importAccount({
    required String key,
    required String password,
    String? keyType = AccountStore.seedTypeMnemonic,
    String? cryptoType = 'sr25519',
    String? derivePath = '',
  }) async {
    var code = 'account.recover("$keyType", "$cryptoType", \'$key$derivePath\', "$password")';
    code = code.replaceAll(RegExp(r'\t|\n|\r'), '');
    return jsApi.evalJavascript<Map<String, dynamic>>(code);
  }
}
