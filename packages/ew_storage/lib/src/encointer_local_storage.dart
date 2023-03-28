import 'dart:convert';

import 'package:flutter/foundation.dart';

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
  String? getString(String key) => storage.getString(key);

  @override
  Future<void> setString({required String key, required String value}) {
    return storage.setString(key: key, value: value);
  }

  @override
  bool? getBool(String key) => storage.getBool(key);

  @override
  Future<void> setBool({required String key, required bool value}) {
    return storage.setBool(key: key, value: value);
  }

  @override
  int? getInt(String key) => storage.getInt(key);

  @override
  Future<void> setInt({required String key, required int value}) {
    return storage.setInt(key: key, value: value);
  }

  @override
  double? getDouble(String key) => storage.getDouble(key);

  @override
  Future<void> setDouble({required String key, required double value}) {
    return storage.setDouble(key: key, value: value);
  }

  @override
  List<String>? getListString(String key) => storage.getStringList(key);

  @override
  Future<void> setListString({required String key, required List<String> value}) {
    return storage.setStringList(key: key, value: value);
  }

  @override
  T? getValueJsonDecode<T>(String key) {
    final value = storage.getString('${customKVKey}_$key');
    return (value != null) ? jsonDecode(value) as T : null;
  }

  @override
  Future<void> setValueJsonEncode<T>(String key, T value) {
    return storage.setString(key: '${customKVKey}_$key', value: jsonEncode(value));
  }

  @override
  Future<void> addItemToList(String key, Map<String, dynamic> acc) {
    final ls = (getValueJsonDecode<List<Map<String, dynamic>>>(key) ?? [])..add(acc);
    return storage.setString(key: key, value: jsonEncode(ls));
  }

  @override
  Future<void> removeItemFromList(String key, String itemKey, String itemValue) {
    final ls = (getValueJsonDecode<List<Map<String, dynamic>>>(key) ?? [])
      ..removeWhere((item) => item[itemKey] == itemValue);
    return storage.setString(key: key, value: jsonEncode(ls));
  }

  @override
  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew) {
    final ls = (getValueJsonDecode<List<Map<String, dynamic>>>(key) ?? [])
      ..removeWhere((item) => item[itemKey] == itemValue)
      ..add(itemNew);
    return storage.setString(key: key, value: jsonEncode(ls));
  }

  @override
  Future<T?> getValueJsonDecodeCompute<T>(String key) async {
    final strValue = storage.getString(key);
    final value = strValue != null ? await compute(jsonDecode, strValue) : null;
    return value as T?;
  }

  @override
  Future<void> setValueJsonEncodeCompute<T>(String key, T value) async {
    final str = await compute(jsonEncode, value);
    await storage.setString(key: key, value: str);
  }

  @override
  Future<void> removeKey(String key) => storage.delete(key);

  @override
  Future<bool> clear() => storage.clear();

  // ----------- account methods --------------
  @override
  String? getCurrentAccount() => storage.getString(currentAccountKey);

  @override
  Future<void> setCurrentAccount(String pubKey) {
    return storage.setString(key: currentAccountKey, value: pubKey);
  }

  @override
  Future<void> removeAccount(String pubKey) {
    return removeItemFromList(accountsKey, 'pubKey', pubKey);
  }

  @override
  List<Map<String, dynamic>> getAccountList() {
    return getValueJsonDecode<List<Map<String, dynamic>>>(accountsKey) ?? [];
  }

  @override
  Future<void> addAccount(Map<String, dynamic> acc) => addItemToList(accountsKey, acc);

  @override
  Object? getAccountCache(String? accPubKey, String key) {
    final data = getValueJsonDecode<Map<String, dynamic>>(key);
    return data?[accPubKey];
  }

  @override
  Future<void> setAccountCache(String accPubKey, String key, Object? value) {
    final data = getValueJsonDecode<Map<String, dynamic>>(key) ?? {};
    data[accPubKey] = value;
    return setValueJsonEncode<Map<String, dynamic>>(key, data);
  }

  // ----------- contact methods --------------
  @override
  List<Map<String, dynamic>> getContactList() {
    return getValueJsonDecode<List<Map<String, dynamic>>>(accountsKey) ?? [];
  }

  @override
  Future<void> addContact(Map<String, dynamic> contact) => addItemToList(contactsKey, contact);

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
    return getValueJsonDecode<Map<String, dynamic>>('${seedKey}_$seedType');
  }

  @override
  Future<void> setLocale([String languageCode = 'en']) {
    return storage.setString(key: localKey, value: languageCode);
  }
}
