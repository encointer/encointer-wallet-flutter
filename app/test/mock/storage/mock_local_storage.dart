import 'dart:convert';

import 'package:encointer_wallet/utils/local_storage.dart';

import '../data/mock_account_data.dart';

class MockLocalStorage extends LocalStorage {
  @override
  Future<bool> setCurrentAccount(String pubKey) async {
    currentAccountPubKey = pubKey;
    return Future.value(true);
  }

  @override
  Future<String?> getCurrentAccount() async {
    return Future.value(currentAccountPubKey);
  }

  @override
  Future<Object?> getAccountCache(String? accPubKey, String key) async {
    return Future.value();
  }

  @override
  Future<List<Map<String, dynamic>>> getContactList() async {
    return Future.value(contactList);
  }

  @override
  Future<void> addContact(Map<String, dynamic> contact) async {
    contactList.add(contact);
    return Future.value();
  }

  @override
  Future<void> removeContact(String pubKey) async {
    contactList.removeWhere((i) => i['address'] == pubKey);
    return Future.value();
  }

  @override
  Future<void> updateContact(Map<String, dynamic> con) async {
    contactList
      ..removeWhere((i) => i['pubKey'] == con['pubKey'])
      ..add(con);
    return Future.value();
  }

  @override
  Future<Object?> getObject(String key) async {
    // Log.d("getObject: $storage", 'MockLocalStorage');
    final value = storage[key] as String?;

    if (value != null) {
      final data = jsonDecode(value);
      return data;
    }
    return Future.value();
  }

  @override
  Future<bool> setObject(String key, Object value) async {
    final str = jsonEncode(value);
    storage[key] = str;
    return Future.value(true);
  }

  @override
  Future<bool> removeObject(String key) async {
    storage.remove(key);
    return Future.value(true);
  }

  @override
  Future<Map<String, dynamic>?> getMap(String key) async {
    // Log.d("getMap: $storage", 'MockLocalStorage');
    final value = storage[key] as String?;

    if (value != null) {
      // String to `Map<String, dynamic>` conversion
      final data = jsonDecode(value);
      if (data is Map<String, dynamic>?) return data;
    }
    return Future.value();
  }

  @override
  Future<String?> getKV(String cacheKey) {
    return Future.value(storage[cacheKey] as String?);
  }

  @override
  Future<void> setKV(String cacheKey, String value) {
    storage[cacheKey] = value;
    return Future.value();
  }

  @override
  Future<bool> removeKV(String key) async {
    storage.remove(key);
    return Future.value(true);
  }
}
