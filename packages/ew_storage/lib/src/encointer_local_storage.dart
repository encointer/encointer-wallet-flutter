import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:ew_storage/src/interface/encointer_local_storage_interface.dart';
import 'package:ew_storage/src/interface/storage_interface_sync_read.dart';

class EncointerLocalStorage implements EncointerLocalStorageInterface {
  const EncointerLocalStorage(this.storage);

  @override
  final StorageInterfaceSyncRead storage;

  /// to check if biometrics is enabled or not
  static const _biometricEnabledKey = 'BIOMETRIC_ENABLED';
  static const defaultBiometricEnabled = false;

  /// Localization key
  static const _localKey = 'locale';
  static const userLoggedKey = 'USER_LOGGED';
  static const defaultUserLogged = false;
  static const accountsKey = 'wallet_account_list';
  static const currentAccountKey = 'wallet_current_account';
  static const encointerCommunityKey = 'wallet_encointer_community';
  static const contactsKey = 'wallet_contact_list';
  static const seedKey = 'wallet_seed';
  static const customKVKey = 'wallet_kv';
  static const meetUpNotificationKey = 'meet_up_notification';

  @override
  String? getKV(String key) => storage.getString(key);

  @override
  List<Map<String, dynamic>> getAccountList() => getList(accountsKey);

  @override
  String? getCurrentAccount() => getKV(currentAccountKey);

  // @override
  String? getChosenCid() => getKV(encointerCommunityKey);

  @override
  List<Map<String, dynamic>> getContactList() => getList(contactsKey);

  @override
  List<String>? getListString(String key) => storage.getStringList(key);

  @override
  List<String>? getShownMessages() => getListString(meetUpNotificationKey);

  @override
  bool isBiometricEnabled() => storage.getBool(_biometricEnabledKey) ?? defaultBiometricEnabled;

  @override
  Object? getObject(String key) {
    final value = getKV('${customKVKey}_$key');
    return (value != null) ? jsonDecode(value) : null;
  }

  @override
  Map<String, dynamic>? getSeeds(String seedType) {
    final value = getKV('${seedKey}_$seedType');
    return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
  }

  @override
  Map<String, dynamic>? getMap(String key) {
    final value = getKV('${customKVKey}_$key');
    return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
  }

  @override
  Locale? getLocale() {
    final locale = storage.getString(_localKey);
    return locale != null ? Locale(locale) : null;
  }

  @override
  Object? getAccountCache(String? accPubKey, String key) {
    final data = getObject(key) as Map<String, dynamic>?;
    return data?[accPubKey];
  }

  @override
  List<Map<String, dynamic>> getList(String key) {
    final str = getKV(key);
    return str != null
        ? (jsonDecode(str) as List).map((i) => Map<String, dynamic>.from(i as Map<String, dynamic>)).toList()
        : [];
  }

  // --------------- set -------------

  @override
  Future<bool> setKV(String key, String value) => storage.setString(key: key, value: value);

  @override
  Future<void> addAccount(Map<String, dynamic> acc) => addItemToList(accountsKey, acc);

  @override
  Future<bool> setCurrentAccount(String pubKey) => setKV(currentAccountKey, pubKey);

  Future<bool> setChosenCid(String cid) => setKV(encointerCommunityKey, cid);

  @override
  Future<void> addContact(Map<String, dynamic> contact) => addItemToList(contactsKey, contact);

  @override
  Future<bool> setObject(String key, Object value) => setKV('${customKVKey}_$key', jsonEncode(value));

  @override
  Future<bool> setLocale(Locale? value) => storage.setString(key: _localKey, value: value?.languageCode ?? 'en');

  @override
  Future<bool> setBiometricEnabled({required bool value}) => storage.setBool(key: _biometricEnabledKey, value: value);

  @override
  Future<void> setListString(String key, List<String> value) => storage.setStringList(key: key, value: value);

  @override
  Future<void> updateContact(Map<String, dynamic> con) {
    return updateItemInList(contactsKey, 'address', con['address'] as String?, con);
  }

  @override
  Future<bool> setShownMessages(List<String> value) async {
    await setListString(meetUpNotificationKey, value);
    return true;
  }

  @override
  Future<void> addItemToList(String key, Map<String, dynamic> acc) async {
    final ls = getList(key)..add(acc);
    await setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> setAccountCache(String accPubKey, String key, Object? value) async {
    final data = (getObject(key) as Map<String, dynamic>?) ?? {};
    data[accPubKey] = value;
    await setObject(key, data);
  }

  @override
  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew) async {
    final ls = getList(key)
      ..removeWhere((item) => item[itemKey] == itemValue)
      ..add(itemNew);
    await setKV(key, jsonEncode(ls));
  }

  // --------------- remove ----------

  @override
  Future<void> removeAccount(String pubKey) => removeItemFromList(accountsKey, 'pubKey', pubKey);

  @override
  Future<void> removeContact(String address) => removeItemFromList(contactsKey, 'address', address);

  @override
  Future<bool> removeKey(String key) => removeKey('${customKVKey}_$key');

  // cache timeout 10 minutes
  static const int customCacheTimeLength = 10 * 60 * 1000;

  static bool checkCacheTimeout(int cacheTime) {
    return DateTime.now().millisecondsSinceEpoch - customCacheTimeLength > cacheTime;
  }

  @override
  Future<bool> clear() => storage.clear();

  @override
  Future<void> removeItemFromList(String key, String itemKey, String itemValue) async {
    final ls = getList(key)..removeWhere((item) => item[itemKey] == itemValue);
    await setKV(key, jsonEncode(ls));
  }
}
