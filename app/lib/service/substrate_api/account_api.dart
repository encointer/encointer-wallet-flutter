import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';

class AccountApi {
  AccountApi(this.store, this.jsApi);

  final JSApi jsApi;
  final AppStore store;
  void Function()? fetchAccountData;

  Future<void> initAccounts() async {
    if (store.account.accountList.isNotEmpty) {
      final accounts = jsonEncode(store.account.accountList.map(AccountData.toJson).toList());
      await jsApi.evalJavascript<void>('account.initKeys($accounts)');
    }
  }

  void setFetchAccountData(void Function()? fetchAccountData) {
    this.fetchAccountData = fetchAccountData;
  }

  /// decode addresses to publicKeys
  Future<Map> decodeAddresses(List<String> addresses) async {
    if (addresses.isEmpty) return {};
    final res = await jsApi.evalJavascript<Map<String, dynamic>?>('account.decodeAddress(${jsonEncode(addresses)})');
    return res ?? {};
  }

  /// Decode one address to the corresponding pubKey.
  Future<String> addressToPubKey(String address) async {
    final pubKeyAddress = await decodeAddresses([address]);
    final pubKey = pubKeyAddress.keys.toList()[0] as String;
    return pubKey;
  }

  Future<String> addressFromUri(String uri) async {
    final address = await jsApi.evalJavascript<String>('account.addressFromUri("$uri")');

    Log.d('addressFromUri: $address', 'AccountApi');
    return address;
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

  Future<Map<String, dynamic>> sendTxAndShowNotification(
    Map<String, dynamic> txInfo,
    List<dynamic>? params, {
    String? rawParam,
    String? cid,
  }) async {
    final res = await sendTx(txInfo, params, rawParam: rawParam);

    if (res['hash'] != null) {
      final hash = res['hash'] as String;
      unawaited(NotificationPlugin.showNotification(
        int.parse(hash.substring(0, 6)),
        '${txInfo['notificationTitle']}',
        '${txInfo['notificationBody']}',
        cid: cid,
      ));
    }
    return res;
  }

  Future<Map<String, dynamic>> sendTx(Map txInfo, List? params, {String? rawParam}) async {
    final param = rawParam ?? jsonEncode(params);
    final call = 'account.sendTx(${jsonEncode(txInfo)}, $param)';
    Log.d('sendTx call: $call', 'AccountApi');
    return jsApi.evalJavascript<Map<String, dynamic>>(call);
  }

  Future<String> generateAccount() async {
    final acc = await jsApi.evalJavascript<Map<String, dynamic>>('account.gen()');
    return acc['mnemonic'] as String;
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

  Future<dynamic> checkAccountPassword(AccountData account, String pass) async {
    final pubKey = account.pubKey;
    Log.d('checkpass: $pubKey, $pass', 'AccountApi');
    return jsApi.evalJavascript('account.checkPassword("$pubKey", "$pass")');
  }
}
