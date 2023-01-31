import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
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

      final ss58 = jsonEncode(networkSs58Map.values.toSet().toList());
      final keys = await jsApi.evalJavascript<Map<String, dynamic>>('account.initKeys($accounts, $ss58)');
      store.account.setPubKeyAddressMap(Map<String, Map>.from(keys));
    }

    // and contacts icons
    final contacts = List<AccountData>.of(store.settings.contactList)
      // set pubKeyAddressMap for observation accounts
      ..retainWhere((i) => i.observation ?? false);
    final observations = contacts.map((i) => i.pubKey).toList();
    if (observations.isNotEmpty) {
      encodeAddress(observations);
    }
  }

  void setFetchAccountData(void Function()? fetchAccountData) {
    this.fetchAccountData = fetchAccountData;
  }

  /// Encodes publicKeys to SS58-addresses
  Future<List<String?>> encodeAddress(List<String?> pubKeys) async {
    final ss58 = jsonEncode(networkSs58Map.values.toSet().toList());
    final res =
        await jsApi.evalJavascript<Map<String, dynamic>>('account.encodeAddress(${jsonEncode(pubKeys)}, $ss58)');

    store.account.setPubKeyAddressMap(Map<String, Map>.from(res));
    final addresses = <String?>[];

    for (final pubKey in pubKeys) {
      Log.d('New entry for pubKeyAddressMap: Key: $pubKey, address: ${res[store.settings]}', 'AccountApi');
      addresses.add(store.account.pubKeyAddressMap[store.settings.endpoint.ss58]![pubKey!]);
    }

    return addresses;
  }

  /// decode addresses to publicKeys
  Future<Map> decodeAddress(List<String> addresses) async {
    if (addresses.isEmpty) return {};

    final res = await jsApi.evalJavascript<Map<String, dynamic>?>('account.decodeAddress(${jsonEncode(addresses)})');
    if (res != null) {
      store.account.setPubKeyAddressMap(Map<String, Map>.from({'${store.settings.endpoint.ss58}': res}));
    }
    return res ?? {};
  }

  Future<String> addressFromUri(String uri) async {
    final address = await jsApi.evalJavascript<String>('account.addressFromUri("$uri")');

    Log.d('addressFromUri: $address', 'AccountApi');
    return address;
  }

  /// query address with account index
  Future<List<dynamic>?> queryAddressWithAccountIndex(String index) async {
    final res = await jsApi.evalJavascript<List<dynamic>?>(
      'account.queryAddressWithAccountIndex("$index", ${store.settings.endpoint.ss58})',
    );
    return res;
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
    store.setCurrentAccount(current);

    await store.loadAccountCache();
    if (fetchData) fetchAccountData?.call();
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

  Future<void> generateAccount() async {
    final acc = await jsApi.evalJavascript<Map<String, dynamic>>('account.gen()');
    store.account.setNewAccountKey(acc['mnemonic'] as String);
  }

  Future<Map<String, dynamic>> importAccount({
    String? keyType = AccountStore.seedTypeMnemonic,
    String? cryptoType = 'sr25519',
    String? derivePath = '',
  }) async {
    final key = store.account.newAccount.key;
    final pass = store.account.newAccount.password;
    var code = 'account.recover("$keyType", "$cryptoType", \'$key$derivePath\', "$pass")';
    code = code.replaceAll(RegExp(r'\t|\n|\r'), '');
    return jsApi.evalJavascript<Map<String, dynamic>>(code);
  }

  Future<dynamic> checkAccountPassword(AccountData account, String pass) async {
    final pubKey = account.pubKey;
    Log.d('checkpass: $pubKey, $pass', 'AccountApi');
    return jsApi.evalJavascript('account.checkPassword("$pubKey", "$pass")');
  }

  Future<List<dynamic>> fetchAddressIndex(List addresses) async {
    if (addresses.isEmpty) return [];

    addresses.retainWhere((i) => !store.account.addressIndexMap.keys.contains(i));
    if (addresses.isEmpty) return [];

    final res = await jsApi.evalJavascript<List<dynamic>>('account.getAccountIndex(${jsonEncode(addresses)})');
    store.account.setAddressIndex(res);

    return res;
  }
}
