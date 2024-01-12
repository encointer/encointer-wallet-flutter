import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///! LegacyLocalStorage interface to recover the accounts that have been created
/// with JS. It has been decided to extract this part of the code of the regular
/// local storage such that it is not accidentally changed.
///
/// It must always be compatible with the cache of app version < v1.11.6.

abstract class LegacyStorageInterface {

  Future<List<Map<String, dynamic>>> getAccountList();

  Future<bool> setSeeds(String seedType, Map value);

  Future<Map<String, dynamic>> getSeeds(String seedType);
}

const accountsKey = 'wallet_account_list';
const seedKey = 'wallet_seed';

class LegacyLocalStorage extends LegacyStorageInterface {
  LegacyLocalStorage();

  final storage = const _LegacyLocalStorage();

  @override
  Future<List<Map<String, dynamic>>> getAccountList() async {
    return storage.getList(accountsKey);
  }

  @override
  Future<bool> setSeeds(String seedType, Map value) async {
    return storage.setKV('${seedKey}_$seedType', jsonEncode(value));
  }

  @override
  Future<Map<String, dynamic>> getSeeds(String seedType) async {
    final value = await storage.getKV('${seedKey}_$seedType');
    if (value != null) {
      return jsonDecode(value) as Map<String, dynamic>;
    }
    return {};
  }
}

class _LegacyLocalStorage {
  const _LegacyLocalStorage();

  Future<String?> getKV(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> setKV(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<List<Map<String, dynamic>>> getList(String storeKey) async {
    var res = <Map<String, dynamic>>[];

    final str = await getKV(storeKey);
    if (str != null) {
      final l = jsonDecode(str);
      res = (l as List).map((i) => Map<String, dynamic>.from(i as Map<String, dynamic>)).toList();
    }
    return res;
  }
}

class LegacyLocalStorageMock extends LegacyStorageInterface {
  final accountsKey = 'wallet_account_list';
  final seedKey = 'wallet_seed';
  final customKVKey = 'wallet_kv';

  final Map<String, String> _seeds = {};
  final List<Map<String, String>> accounts = [];

  @override
  Future<List<Map<String, dynamic>>> getAccountList() async {
    return accounts;
  }

  @override
  Future<bool> setSeeds(String seedType, Map value) async {
    _seeds['${seedKey}_$seedType'] = jsonEncode(value);
    return Future.value(true);
  }

  @override
  Future<Map<String, dynamic>> getSeeds(String seedType) async {
    final value = _seeds['${seedKey}_$seedType'];
    if (value != null) {
      return jsonDecode(value) as Map<String, dynamic>;
    }
    return {};
  }
}
