import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';

class AccountApi {
  const AccountApi(this.jsApi);

  final JSApi jsApi;

  Future<Map<dynamic, dynamic>?> initAccounts(
    List<AccountData> accountList,
    List<AccountData> contactList,
  ) async {
    if (accountList.isNotEmpty) {
      final accounts = jsonEncode(accountList.map(AccountData.toJson).toList());

      final ss58 = jsonEncode(networkSs58Map.values.toSet().toList());
      final keys = await jsApi.evalJavascript<Map<String, dynamic>>('account.initKeys($accounts, $ss58)');
      return keys;
    } else {
      return null;
    }
  }

  /// Encodes publicKeys to SS58-addresses
  Future<Map<dynamic, dynamic>> encodeAddress(List<String?> pubKeys) async {
    final ss58 = jsonEncode(networkSs58Map.values.toSet().toList());
    return jsApi.evalJavascript<Map<dynamic, dynamic>>('account.encodeAddress(${jsonEncode(pubKeys)}, $ss58)');
  }

  /// decode addresses to publicKeys
  Future<Map<String, dynamic>?> decodeAddress(List<String> addresses) async {
    if (addresses.isEmpty) return {};
    final res = await jsApi.evalJavascript<Map<String, dynamic>>('account.decodeAddress(${jsonEncode(addresses)})');

    return res;
  }

  Future<String> addressFromUri(String uri) async {
    final address = await jsApi.evalJavascript<String>('account.addressFromUri("$uri")');

    Log.d('addressFromUri: $address', 'AccountApi');
    return address;
  }

  /// query address with account index
  Future<List<dynamic>?> queryAddressWithAccountIndex(String index, int? ss58) async {
    final res = await jsApi.evalJavascript<List<dynamic>?>('account.queryAddressWithAccountIndex("$index", $ss58)');
    return res;
  }

  String? changeCurrentAccount({String? pubKey, required List<AccountData> accounts}) {
    if (pubKey == null) {
      return accounts.isNotEmpty ? accounts[0].pubKey : '';
    } else {
      return null;
    }
  }

  Future<Map<dynamic, dynamic>> sendTxAndShowNotification(
    Map? txInfo,
    List? params,
    String? pageTile,
    String? notificationTitle, {
    String? rawParam,
  }) async {
    final res = await sendTx(txInfo, params, rawParam: rawParam) as Map;

    if (res['hash'] != null) {
      final hash = res['hash'] as String;
      NotificationPlugin.showNotification(
        int.parse(hash.substring(0, 6)),
        notificationTitle,
        '$pageTile - ${txInfo!['module']}.${txInfo['call']}',
      );
    }
    return res;
  }

  Future<dynamic> sendTx(Map? txInfo, List? params, {String? rawParam}) async {
    final param = rawParam ?? jsonEncode(params);
    final call = 'account.sendTx(${jsonEncode(txInfo)}, $param)';
    Log.d('sendTx call: $call', 'AccountApi');
    return jsApi.evalJavascript(call);
  }

  Future<Map<String, dynamic>> generateAccount() {
    return jsApi.evalJavascript<Map<String, dynamic>>('account.gen()');
  }

  Future<Map<String, dynamic>> importAccount(
    String? key,
    String pass, {
    String? keyType = AccountStore.seedTypeMnemonic,
    String? cryptoType = 'sr25519',
    String? derivePath = '',
  }) async {
    var code = 'account.recover("$keyType", "$cryptoType", \'$key$derivePath\', "$pass")';
    code = code.replaceAll(RegExp(r'\t|\n|\r'), '');
    return jsApi.evalJavascript<Map<String, dynamic>>(code);
  }

  Future<dynamic> checkAccountPassword(AccountData account, String pass) async {
    final pubKey = account.pubKey;
    Log.d('checkpass: $pubKey, $pass', 'AccountApi');
    return jsApi.evalJavascript('account.checkPassword("$pubKey", "$pass")');
  }

  Future<List<dynamic>> fetchAddressIndex(List addresses, Iterable<String?> keys) async {
    if (addresses.isEmpty) return [];

    addresses.retainWhere((element) => !keys.contains(element));
    if (addresses.isEmpty) return [];

    final res = await jsApi.evalJavascript<List<dynamic>>('account.getAccountIndex(${jsonEncode(addresses)})');
    return res;
  }
}
