import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:ew_storage/src/interface/pref_interface_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> endorphineCointer = {
  'name': 'Endorphine Cointer',
  'address': '5HKczFYLWA3LDZrKN4kK8wmH6pBv6pxiwbYhmhjiN3KHiQHz',
  'pubKey': '0x00',
  'encoded':
      'PkGLcXnzjnIn77H4bhaWEpKtOSz1GpOK9ZH4GlstcuEAgAAAAQAAAAgAAADEKys5iFgIyCIceLKTiN9fxkgNZARxVRsgpwUt0xg5f4cYkDPy/+ui8A4XPu8BWl4fwUMJUJ7vZW+H1Zi+2lGQhdhOh9U1aECcOUQoXygR631vRrRU26lvKLHTJlhKEUWifd8h0r4mVfsgHg8Mx8DfHaDwvsuyVDGvyqPSxj55PffWrSEgFgK1b4wgebQgYgtQB+bFbKyc4wRVI1Ua',
  'encoding': {
    'content': ['pkcs8', 'sr25519'],
    'type': ['scrypt', 'xsalsa20-poly1305'],
    'version': '3'
  },
  'meta': {'genesisHash': '', 'name': 'Endorphine Cointer', 'whenCreated': 1616850683478},
  'mnemonic': 'clap mechanic diary rose vital current eyebrow mean limb pulse portion plate',
  'memo': null,
  'observation': null
};
List<Map<String, dynamic>> accList = [];
String currentAccountPubKey = '';
List<Map<String, dynamic>> contactList = [endorphineCointer];
Map<String, dynamic> storage = <String, dynamic>{};

List<dynamic> pubKeys = accList.map((e) => e['pubKey']).toList();

class MockLocalStorage extends PreferencesStorage {
  /// Localization key
  static const String _localKey = 'locale';

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

  @override
  Future<String?> getKV(String key) {
    return Future.value();
  }

  @override
  Future<void> setKV(String key, String value) {
    return Future.value();
  }

  @override
  Future<void> addItemToList(String key, Map<String, dynamic> acc) {
    throw UnimplementedError();
  }

  @override
  Future<bool> clear() {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getList(String key) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getListString(String key) {
    throw UnimplementedError();
  }

  @override
  Future<Locale>? getLocale() async {
    final prefs = await SharedPreferences.getInstance();

    final locale = prefs.getString(_localKey);

    return Locale(locale ?? 'en');
  }

  @override
  Future<List<String>> getShownMessages() {
    throw UnimplementedError();
  }

  @override
  bool isBiometricEnabled() {
    throw UnimplementedError();
  }

  @override
  Future<void> removeItemFromList(String key, String itemKey, String itemValue) {
    throw UnimplementedError();
  }

  @override
  Future<void> setAccountCache(String? accPubKey, String key, Object? value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setBiometricEnabled(bool? value) {
    throw UnimplementedError();
  }

  @override
  Future<void> setListString(String key, List<String> value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setLocale(Locale? value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setShownMessages(List<String> value) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateItemInList(
    String key,
    String itemKey,
    String? itemValue,
    Map<String, dynamic> itemNew,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setSeeds(String seedType, Map value) {
    throw UnimplementedError();
  }
}
