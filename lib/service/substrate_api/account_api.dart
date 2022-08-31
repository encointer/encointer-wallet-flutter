import 'dart:async';
import 'dart:convert';

import 'package:encointer_wallet/config/consts.dart';
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
    if (store.account.accountList.length > 0) {
      String accounts = jsonEncode(store.account.accountList.map((i) => AccountData.toJson(i)).toList());

      String ss58 = jsonEncode(network_ss58_map.values.toSet().toList());
      Map keys = await jsApi.evalJavascript('account.initKeys($accounts, $ss58)');
      store.account.setPubKeyAddressMap(Map<String, Map>.from(keys));
    }

    // and contacts icons
    List<AccountData> contacts = List<AccountData>.of(store.settings.contactList);
    // set pubKeyAddressMap for observation accounts
    contacts.retainWhere((i) => i.observation ?? false);
    List<String?> observations = contacts.map((i) => i.pubKey).toList();
    if (observations.length > 0) {
      encodeAddress(observations);
    }
  }

  void setFetchAccountData(Function fetchAccountData) {
    this.fetchAccountData = fetchAccountData;
  }

  /// Encodes publicKeys to SS58-addresses
  Future<List<String?>> encodeAddress(List<String?> pubKeys) async {
    String ss58 = jsonEncode(network_ss58_map.values.toSet().toList());
    Map res = await jsApi.evalJavascript(
      'account.encodeAddress(${jsonEncode(pubKeys)}, $ss58)',
      allowRepeat: true,
    );

    store.account.setPubKeyAddressMap(Map<String, Map>.from(res));
    var addresses = <String?>[];

    for (var pubKey in pubKeys) {
      _log('New entry for pubKeyAddressMap: Key: $pubKey, address: ${res[store.settings]}');
      addresses.add(store.account.pubKeyAddressMap[store.settings.endpoint.ss58]![pubKey!]);
    }

    return addresses;
  }

  /// decode addresses to publicKeys
  Future<Map> decodeAddress(List<String> addresses) async {
    if (addresses.length == 0) {
      return {};
    }
    Map? res = await jsApi.evalJavascript(
      'account.decodeAddress(${jsonEncode(addresses)})',
      allowRepeat: true,
    );
    if (res != null) {
      store.account.setPubKeyAddressMap(Map<String, Map>.from({store.settings.endpoint.ss58.toString(): res}));
    }
    return res ?? {};
  }

  Future<String> addressFromUri(String uri) async {
    dynamic address = await jsApi.evalJavascript(
      'account.addressFromUri("$uri")',
      allowRepeat: true,
    );

    _log('addressFromUri: $address');

    return address;
  }

  /// query address with account index
  Future<List?> queryAddressWithAccountIndex(String index) async {
    final res = await jsApi.evalJavascript(
      'account.queryAddressWithAccountIndex("$index", ${store.settings.endpoint.ss58})',
      allowRepeat: true,
    );
    return res;
  }

  Future<void> changeCurrentAccount({
    String? pubKey,
    bool fetchData = false,
  }) async {
    String? current = pubKey;
    if (pubKey == null) {
      if (store.account.accountListAll.length > 0) {
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
    String param = rawParam != null ? rawParam : jsonEncode(params);
    print(txInfo);
    Map res = await jsApi.evalJavascript('account.txFeeEstimate(${jsonEncode(txInfo)}, $param)', allowRepeat: true);
    return res;
  }

  Future<dynamic> sendTxAndShowNotification(
    Map? txInfo,
    List? params,
    String? pageTile,
    String? notificationTitle, {
    String? rawParam,
  }) async {
    Map res = await sendTx(txInfo, params, rawParam: rawParam);

    if (res['hash'] != null) {
      String hash = res['hash'];
      NotificationPlugin.showNotification(
        int.parse(hash.substring(0, 6)),
        notificationTitle,
        '$pageTile - ${txInfo!['module']}.${txInfo['call']}',
      );
    }
    return res;
  }

  Future<dynamic> sendTx(Map? txInfo, List? params, {String? rawParam}) async {
    String param = rawParam != null ? rawParam : jsonEncode(params);
    String call = 'account.sendTx(${jsonEncode(txInfo)}, $param)';
    _log('sendTx call: $call');
    return jsApi.evalJavascript(call, allowRepeat: true);
  }

  Future<void> generateAccount() async {
    Map<String, dynamic> acc = await jsApi.evalJavascript('account.gen()');
    store.account.setNewAccountKey(acc['mnemonic']);
  }

  Future<Map<String, dynamic>> importAccount({
    String? keyType = AccountStore.seedTypeMnemonic,
    String? cryptoType = 'sr25519',
    String? derivePath = '',
  }) async {
    String? key = store.account.newAccount.key;
    String pass = store.account.newAccount.password;
    String code = 'account.recover("$keyType", "$cryptoType", \'$key$derivePath\', "$pass")';
    code = code.replaceAll(RegExp(r'\t|\n|\r'), '');
    Map<String, dynamic> acc = await jsApi.evalJavascript(code, allowRepeat: true);
    return acc;
  }

  Future<dynamic> checkAccountPassword(AccountData account, String pass) async {
    String? pubKey = account.pubKey;
    print('checkpass: $pubKey, $pass');
    return jsApi.evalJavascript(
      'account.checkPassword("$pubKey", "$pass")',
      allowRepeat: true,
    );
  }

  Future<List> fetchAddressIndex(List addresses) async {
    if (addresses.length == 0) {
      return [];
    }
    addresses.retainWhere((i) => !store.account.addressIndexMap.keys.contains(i));
    if (addresses.length == 0) {
      return [];
    }

    var res = await jsApi.evalJavascript(
      'account.getAccountIndex(${jsonEncode(addresses)})',
      allowRepeat: true,
    );
    store.account.setAddressIndex(res);
    return res;
  }

  Future<List> fetchAccountsIndex() async {
    final addresses = store.account.accountListAll.map((e) => e.address).toList();
    if (addresses.length == 0) {
      return [];
    }

    var res = await jsApi.evalJavascript(
      'account.getAccountIndex(${jsonEncode(addresses)})',
      allowRepeat: true,
    );
    store.account.setAccountsIndex(res);
    return res;
  }
}

_log(String msg) {
  print('[accountApi] $msg');
}
