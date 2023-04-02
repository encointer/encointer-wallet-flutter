import 'dart:core';

import 'package:ew_storage/src/interface/encointer.dart';
import 'package:ew_storage/src/storages/sync_storage.dart';

class MockLocalStorage extends SyncStorage implements EncointerStorageInterface {
  const MockLocalStorage(super.storage);

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
  Future<void> setLocale([String languageCode = 'en']) => throw UnimplementedError();
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
