import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:ew_storage/src/interface/encointer_local_storage_interface.dart';
import 'package:ew_storage/src/interface/storage_interface_sync_read.dart';

class MockLocalStorage implements EncointerLocalStorageInterface {
  const MockLocalStorage(this.storage);

  @override
  final StorageInterfaceSyncRead storage;

  // ----------- base methods --------------
  @override
  Map<String, dynamic>? getMap(String key) {
    final value = mockStorage[key] as String?;
    return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
  }

  @override
  List<Map<String, dynamic>> getMapList(String key) => throw UnimplementedError();

  @override
  List<String>? getListString(String key) => throw UnimplementedError();

  @override
  Object? getObject(String key) {
    final value = mockStorage[key] as String?;
    return value != null ? jsonDecode(value) : null;
  }

  @override
  Future<void> setObject(String key, Object value) async {
    mockStorage[key] = jsonEncode(value);
  }

  @override
  String? getKV(String key) => null;

  @override
  Future<void> setKV(String key, String value) => Future.value();

  @override
  Future<void> addItemToList(String key, Map<String, dynamic> acc) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeItemFromList(String key, String itemKey, String itemValue) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeKey(String key) => Future.value();

  @override
  Future<void> clear() => throw UnimplementedError();

  // ----------- account methods --------------
  @override
  String? getCurrentAccount() => currentAccountPubKey;

  @override
  Future<void> setCurrentAccount(String pubKey) async {
    currentAccountPubKey = pubKey;
  }

  @override
  Future<void> removeAccount(String pubKey) async {
    accList.removeWhere((i) => i['pubKey'] == pubKey);
  }

  @override
  List<Map<String, dynamic>> getAccountList() => accList;

  @override
  Future<void> addAccount(Map<String, dynamic> acc) async {
    accList.add(acc);
  }

  @override
  Future<Object?> getAccountCache(String? accPubKey, String key) {
    return Future.value();
  }

  @override
  Future<void> setAccountCache(String? accPubKey, String key, Object? value) {
    throw UnimplementedError();
  }

  // ----------- contact methods --------------
  @override
  List<Map<String, dynamic>> getContactList() => contactList;

  @override
  Future<void> addContact(Map<String, dynamic> contact) async {
    contactList.add(contact);
  }

  @override
  Future<void> removeContact(String address) async {
    contactList.removeWhere((i) => i['address'] == address);
  }

  @override
  Future<void> updateContact(Map<String, dynamic> con) async {
    contactList
      ..removeWhere((i) => i['pubKey'] == con['pubKey'])
      ..add(con);
  }

  // ----------- community methods --------------
  @override
  Map<String, dynamic>? getSeeds(String seedType) => {};

  @override
  Future<bool> setLocale(Locale? value) => throw UnimplementedError();
}

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
Map<String, dynamic> mockStorage = <String, dynamic>{};

List<dynamic> pubKeys = accList.map((e) => e['pubKey']).toList();
