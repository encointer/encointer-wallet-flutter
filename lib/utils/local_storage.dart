import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/communities/community_identifier.dart';

class LocalStorage {
  final accountsKey = 'wallet_account_list';
  final currentAccountKey = 'wallet_current_account';
  final encointerCommunityKey = 'wallet_encointer_community';
  final contactsKey = 'wallet_contact_list';
  final seedKey = 'wallet_seed';
  final customKVKey = 'wallet_kv';

  final storage = _LocalStorage();

  Future<void> addAccount(Map<String, dynamic> acc) async {
    return storage.addItemToList(accountsKey, acc);
  }

  Future<void> removeAccount(String pubKey) async {
    return storage.removeItemFromList(accountsKey, 'pubKey', pubKey);
  }

  Future<List<Map<String, dynamic>>> getAccountList() async {
    return storage.getList(accountsKey);
  }

  Future<bool> setCurrentAccount(String pubKey) async {
    return storage.setKV(currentAccountKey, pubKey);
  }

  Future<String?> getKV(String cacheKey) {
    return storage.getKV(cacheKey);
  }

  Future<void> setKV(String cacheKey, String value) {
    return storage.setKV(cacheKey, value);
  }

  Future<String?> getCurrentAccount() async {
    return storage.getKV(currentAccountKey);
  }

  Future<bool> setChosenCid(CommunityIdentifier cid) async {
    return storage.setKV(encointerCommunityKey, cid);
  }

  Future<String?> getChosenCid() async {
    return storage.getKV(encointerCommunityKey);
  }

  Future<void> addContact(Map<String, dynamic> contact) async {
    return storage.addItemToList(contactsKey, contact);
  }

  Future<void> removeContact(String address) async {
    return storage.removeItemFromList(contactsKey, 'address', address);
  }

  Future<void> updateContact(Map<String, dynamic> con) async {
    return storage.updateItemInList(contactsKey, 'address', con['address'], con);
  }

  Future<List<Map<String, dynamic>>> getContactList() async {
    return storage.getList(contactsKey);
  }

  Future<List<Map<String, dynamic>>> getList(String cacheKey) async {
    return storage.getList(cacheKey);
  }

  Future<bool> setSeeds(String seedType, Map value) async {
    return storage.setKV('${seedKey}_$seedType', jsonEncode(value));
  }

  Future<Map<String, dynamic>> getSeeds(String seedType) async {
    String? value = await storage.getKV('${seedKey}_$seedType');
    if (value != null) {
      return jsonDecode(value);
    }
    return {};
  }

  Future<bool> setObject(String key, Object value) async {
    String str = await compute(jsonEncode, value);
    return storage.setKV('${customKVKey}_$key', str);
  }

  Future<Object?> getObject(String key) async {
    String? value = await storage.getKV('${customKVKey}_$key');
    if (value != null) {
      dynamic data = await compute(jsonDecode, value);
      return data as Object;
    }
    return Future.value(null);
  }

  Future<bool> removeKey(String key) {
    return storage.removeKey('${customKVKey}_$key');
  }

  /// Gets the more specific return type that `GetObject. This should always be preferred.
  ///
  /// Should be used instead of `getObject`, see #533.
  Future<Map<String, dynamic>?> getMap(String key) async {
    String? value = await storage.getKV('${customKVKey}_$key');

    if (value != null) {
      // String to `Map<String, dynamic>` conversion
      var data = await compute(jsonDecode, value);
      return data;
    }
    return Future.value(null);
  }

  Future<void> setAccountCache(String? accPubKey, String key, Object? value) async {
    Map? data = await getObject(key) as Map?;
    if (data == null) {
      data = {};
    }
    data[accPubKey] = value;
    setObject(key, data);
  }

  Future<Object?> getAccountCache(String? accPubKey, String key) async {
    Map? data = await getObject(key) as Map?;
    if (data == null) {
      return Future.value(null);
    }
    return data[accPubKey];
  }

  // cache timeout 10 minutes
  static const int customCacheTimeLength = 10 * 60 * 1000;

  static bool checkCacheTimeout(int cacheTime) {
    return DateTime.now().millisecondsSinceEpoch - customCacheTimeLength > cacheTime;
  }
}

class _LocalStorage {
  Future<String?> getKV(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> setKV(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<void> addItemToList(String storeKey, Map<String, dynamic> acc) async {
    List<Map<String, dynamic>> ls = await getList(storeKey);
    ls.add(acc);
    setKV(storeKey, jsonEncode(ls));
  }

  Future<void> removeItemFromList(String storeKey, String itemKey, String itemValue) async {
    var ls = await getList(storeKey);
    ls.removeWhere((item) => item[itemKey] == itemValue);
    setKV(storeKey, jsonEncode(ls));
  }

  Future<void> updateItemInList(
      String storeKey, String itemKey, String? itemValue, Map<String, dynamic> itemNew) async {
    var ls = await getList(storeKey);
    ls.removeWhere((item) => item[itemKey] == itemValue);
    ls.add(itemNew);
    setKV(storeKey, jsonEncode(ls));
  }

  Future<List<Map<String, dynamic>>> getList(String storeKey) async {
    List<Map<String, dynamic>> res = [];

    String? str = await getKV(storeKey);
    if (str != null) {
      Iterable l = jsonDecode(str);
      res = l.map((i) => Map<String, dynamic>.from(i)).toList();
    }
    return res;
  }
}
