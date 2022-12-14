import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/core/js_api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';

class AccountApi {
  AccountApi(this.store, this.jsApi);

  final JSApi jsApi;
  final AppStore store;
  Function? fetchAccountData;

  Future<void> initAccounts() async {
    if (store.account.accountList.isNotEmpty) {
      final accounts = jsonEncode(store.account.accountList.map((i) => AccountData.toJson(i)).toList());

      final ss58 = jsonEncode(networkSs58Map.values.toSet().toList());
      final keys = await jsApi.evalJavascript('account.initKeys($accounts, $ss58)');
      store.account.setPubKeyAddressMap(Map<String, Map>.from(keys as Map));
    }

    // and contacts icons
    final contacts = List<AccountData>.of(store.settings.contactList);
    // set pubKeyAddressMap for observation accounts
    contacts.retainWhere((i) => i.observation ?? false);
    final observations = contacts.map((i) => i.pubKey).toList();
    if (observations.isNotEmpty) {
      encodeAddress(observations);
    }
  }

  void setFetchAccountData(Function fetchAccountData) {
    this.fetchAccountData = fetchAccountData;
  }

  /// Encodes publicKeys to SS58-addresses
  Future<List<String?>> encodeAddress(List<String?> pubKeys) async {
    final ss58 = jsonEncode(networkSs58Map.values.toSet().toList());
    final res = await jsApi.evalJavascript(
      'account.encodeAddress(${jsonEncode(pubKeys)}, $ss58)',
      allowRepeat: true,
    );

    store.account.setPubKeyAddressMap(Map<String, Map>.from(res as Map));
    final addresses = <String?>[];

    for (final pubKey in pubKeys) {
      Log.d('New entry for pubKeyAddressMap: Key: $pubKey, address: ${res[store.settings]}', 'AccountApi');
      addresses.add(store.account.pubKeyAddressMap[store.settings.endpoint.ss58]![pubKey!]);
    }

    return addresses;
  }

  /// decode addresses to publicKeys
  Future<Map> decodeAddress(List<String> addresses) async {
    if (addresses.isEmpty) {
      return {};
    }
    final res = await jsApi.evalJavascript(
      'account.decodeAddress(${jsonEncode(addresses)})',
      allowRepeat: true,
    );
    if (res != null) {
      store.account.setPubKeyAddressMap(Map<String, Map>.from({store.settings.endpoint.ss58.toString(): res as Map}));
    }
    return res as Map? ?? {};
  }

  Future<String> addressFromUri(String uri) async {
    final address = await jsApi.evalJavascript(
      'account.addressFromUri("$uri")',
      allowRepeat: true,
    );

    Log.d('addressFromUri: $address', 'AccountApi');
    return address as String;
  }

  /// query address with account index
  Future<List?> queryAddressWithAccountIndex(String index) async {
    final res = await jsApi.evalJavascript(
      'account.queryAddressWithAccountIndex("$index", ${store.settings.endpoint.ss58})',
      allowRepeat: true,
    );
    return res as List?;
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
    if (fetchData) {
      if (fetchAccountData != null) {
        fetchAccountData!();
      }
    }
  }

  Future<Map> estimateTxFees(Map txInfo, List? params, {String? rawParam}) async {
    final param = rawParam ?? jsonEncode(params);
    Log.d('$txInfo', 'AccountApi');
    final res = await jsApi.evalJavascript('account.txFeeEstimate(${jsonEncode(txInfo)}, $param)', allowRepeat: true);
    return res as Map;
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
    return jsApi.evalJavascript(call, allowRepeat: true);
  }

  Future<void> generateAccount() async {
    final acc = await jsApi.evalJavascript('account.gen()') as Map<String, dynamic>;
    store.account.setNewAccountKey(acc['mnemonic'] as String?);
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
    final acc = await jsApi.evalJavascript(code, allowRepeat: true);
    return acc as Map<String, dynamic>;
  }

  Future<dynamic> checkAccountPassword(AccountData account, String pass) async {
    final pubKey = account.pubKey;
    Log.d('checkpass: $pubKey, $pass', 'AccountApi');
    return jsApi.evalJavascript(
      'account.checkPassword("$pubKey", "$pass")',
      allowRepeat: true,
    );
  }

  Future<List> fetchAddressIndex(List addresses) async {
    if (addresses.isEmpty) {
      return [];
    }
    addresses.retainWhere((i) => !store.account.addressIndexMap.keys.contains(i));
    if (addresses.isEmpty) {
      return [];
    }

    final res = await jsApi.evalJavascript(
      'account.getAccountIndex(${jsonEncode(addresses)})',
      allowRepeat: true,
    );
    store.account.setAddressIndex(res as List<dynamic>);
    return res;
  }

  Future<List> fetchAccountsIndex() async {
    final addresses = store.account.accountListAll.map((e) => e.address).toList();
    if (addresses.isEmpty) {
      return [];
    }

    final res = await jsApi.evalJavascript(
      'account.getAccountIndex(${jsonEncode(addresses)})',
      allowRepeat: true,
    );
    store.account.setAccountsIndex(res as List<dynamic>);
    return res;
  }
}
