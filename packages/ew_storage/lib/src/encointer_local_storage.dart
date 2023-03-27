import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ew_storage/src/interface/encointer_local_storage_interface.dart';
import 'package:ew_storage/src/interface/storage_interface_sync_read.dart';

class EncointerLocalStorage implements EncointerLocalStorageInterface {
  const EncointerLocalStorage(this.storage);

  @override
  final StorageInterfaceSyncRead storage;

  /// local keys
  static const localKey = 'locale';
  static const accountsKey = 'wallet_account_list';
  static const currentAccountKey = 'wallet_current_account';
  static const contactsKey = 'wallet_contact_list';
  static const seedKey = 'wallet_seed';
  static const customKVKey = 'wallet_kv';

  // ----------- base methods --------------
  @override
  Map<String, dynamic>? getMap(String key) {
    final value = getKV('${customKVKey}_$key');
    return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
  }

  @override
  List<Map<String, dynamic>> getMapList(String key) {
    final str = getKV(key);
    return str != null
        ? (jsonDecode(str) as List).map((i) => Map<String, dynamic>.from(i as Map<String, dynamic>)).toList()
        : [];
  }

  @override
  List<String>? getListString(String key) {
    return storage.getStringList(key);
  }

  @override
  Object? getObject(String key) {
    final value = getKV('${customKVKey}_$key');
    return (value != null) ? jsonDecode(value) : null;
  }

  @override
  Future<void> setObject(String key, Object value) {
    return setKV('${customKVKey}_$key', jsonEncode(value));
  }

  @override
  String? getKV(String key) {
    return storage.getString(key);
  }

  @override
  Future<bool> setKV(String key, String value) {
    return storage.setString(key: key, value: value);
  }

  @override
  Future<void> addItemToList(String key, Map<String, dynamic> acc) {
    final ls = getMapList(key)..add(acc);
    return setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> removeItemFromList(String key, String itemKey, String itemValue) {
    final ls = getMapList(key)..removeWhere((item) => item[itemKey] == itemValue);
    return setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew) {
    final ls = getMapList(key)
      ..removeWhere((item) => item[itemKey] == itemValue)
      ..add(itemNew);
    return setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> removeKey(String key) {
    return storage.delete(key);
  }

  @override
  Future<bool> clear() => storage.clear();

  // ----------- account methods --------------
  @override
  String? getCurrentAccount() => getKV(currentAccountKey);

  @override
  Future<void> setCurrentAccount(String pubKey) {
    return setKV(currentAccountKey, pubKey);
  }

  @override
  Future<void> removeAccount(String pubKey) {
    return removeItemFromList(accountsKey, 'pubKey', pubKey);
  }

  @override
  List<Map<String, dynamic>> getAccountList() {
    return getMapList(accountsKey);
  }

  @override
  Future<void> addAccount(Map<String, dynamic> acc) {
    return addItemToList(accountsKey, acc);
  }

  @override
  Object? getAccountCache(String? accPubKey, String key) {
    final data = getObject(key) as Map<String, dynamic>?;
    return data?[accPubKey];
  }

  @override
  Future<void> setAccountCache(String accPubKey, String key, Object? value) {
    final data = (getObject(key) as Map<String, dynamic>?) ?? {};
    data[accPubKey] = value;
    return setObject(key, data);
  }

  // ----------- contact methods --------------
  @override
  List<Map<String, dynamic>> getContactList() {
    return getMapList(contactsKey);
  }

  @override
  Future<void> addContact(Map<String, dynamic> contact) {
    return addItemToList(contactsKey, contact);
  }

  @override
  Future<void> removeContact(String address) {
    return removeItemFromList(contactsKey, 'address', address);
  }

  @override
  Future<void> updateContact(Map<String, dynamic> con) {
    return updateItemInList(contactsKey, 'address', con['address'] as String?, con);
  }

  // ----------- community methods --------------
  @override
  Map<String, dynamic>? getSeeds(String seedType) {
    final value = getKV('${seedKey}_$seedType');
    return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
  }

  @override
  Future<bool> setLocale(Locale? value) {
    return storage.setString(key: localKey, value: value?.languageCode ?? 'en');
  }
}
