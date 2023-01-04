import 'dart:convert';

import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/utils/local_storage.dart';

class MockLocalStorage extends LocalStorage {
  @override
  Future<List<Map<String, dynamic>>> getAccountList() {
    return Future.value(accList);
  }

  @override
  Future<void> addAccount(Map<String, dynamic> acc) async {
    accList.add(acc);
  }

  @override
  Future<void> removeAccount(String pubKey) async {
    accList.removeWhere((i) => i['pubKey'] == pubKey);
  }

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
  Future<Map<String, dynamic>> getSeeds(String seedType) async {
    return Future.value({});
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
  Future<void> removeContact(String address) async {
    contactList.removeWhere((i) => i['address'] == address);
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
  Future<bool> removeKey(String key) async {
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
}
