import 'dart:convert';

import 'package:flutter/foundation.dart';
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
  String? getKV(String key) {
    return storage.getString(key);
  }

  @override
  Future<bool> setKV(String key, String value) {
    return storage.setString(key: key, value: value);
  }

  @override
  Future<void> addAccount(Map<String, dynamic> acc) async {
    return addItemToList(accountsKey, acc);
  }

  @override
  Future<void> removeAccount(String pubKey) async {
    return removeItemFromList(accountsKey, 'pubKey', pubKey);
  }

  @override
  Future<List<Map<String, dynamic>>> getAccountList() async {
    return getList(accountsKey);
  }

  @override
  Future<bool> setCurrentAccount(String pubKey) async {
    return setKV(currentAccountKey, pubKey);
  }

  @override
  Future<String?> getCurrentAccount() async {
    return getKV(currentAccountKey);
  }

  Future<bool> setChosenCid(String cid) async {
    return setKV(encointerCommunityKey, cid);
  }

  Future<String?> getChosenCid() async {
    return getKV(encointerCommunityKey);
  }

  @override
  Future<void> addContact(Map<String, dynamic> contact) async {
    return addItemToList(contactsKey, contact);
  }

  @override
  Future<void> removeContact(String address) async {
    return removeItemFromList(contactsKey, 'address', address);
  }

  @override
  Future<void> updateContact(Map<String, dynamic> con) async {
    return updateItemInList(contactsKey, 'address', con['address'] as String?, con);
  }

  @override
  Future<List<Map<String, dynamic>>> getContactList() async {
    return getList(contactsKey);
  }

  @override
  Map<String, dynamic>? getSeeds(String seedType) {
    final value = getKV('${seedKey}_$seedType');
    return value != null ? jsonDecode(value) as Map<String, dynamic> : null;
  }

  @override
  Future<bool> setObject(String key, Object value) async {
    final str = await compute(jsonEncode, value);
    return setKV('${customKVKey}_$key', str);
  }

  @override
  Future<Object?> getObject(String key) async {
    final value = getKV('${customKVKey}_$key');
    if (value != null) {
      final dynamic data = await compute(jsonDecode, value);
      return data as Object;
    }
    return Future.value();
  }

  @override
  Future<bool> removeKey(String key) {
    return removeKey('${customKVKey}_$key');
  }

  @override
  Future<Map<String, dynamic>?> getMap(String key) async {
    final value = getKV('${customKVKey}_$key');

    if (value != null) {
      final data = await compute(jsonDecode, value);
      return data as Map<String, dynamic>?;
    }
    return Future.value();
  }

  @override
  Future<void> setAccountCache(String? accPubKey, String key, Object? value) async {
    var data = await getObject(key) as Map?;
    data ??= {};
    data[accPubKey] = value;
    await setObject(key, data);
  }

  @override
  Future<Object?> getAccountCache(String? accPubKey, String key) async {
    final data = await getObject(key) as Map?;
    if (data == null) {
      return Future.value();
    }
    return data[accPubKey];
  }

  // cache timeout 10 minutes
  static const int customCacheTimeLength = 10 * 60 * 1000;

  static bool checkCacheTimeout(int cacheTime) {
    return DateTime.now().millisecondsSinceEpoch - customCacheTimeLength > cacheTime;
  }

  @override
  Future<bool> setShownMessages(List<String> value) async {
    await setListString(meetUpNotificationKey, value);
    return Future.value(true);
  }

  @override
  List<String>? getShownMessages() {
    return getListString(meetUpNotificationKey);
  }

  @override
  Future<bool> setLocale(Locale? value) {
    return storage.setString(key: _localKey, value: value?.languageCode ?? 'en');
  }

  @override
  Locale? getLocale() {
    final locale = storage.getString(_localKey);
    return locale != null ? Locale(locale) : null;
  }

  @override
  Future<bool> setBiometricEnabled({required bool value}) {
    return storage.setBool(key: _biometricEnabledKey, value: value);
  }

  @override
  bool isBiometricEnabled() {
    return storage.getBool(_biometricEnabledKey) ?? defaultBiometricEnabled;
  }

  @override
  Future<bool> clear() {
    return storage.clear();
  }

  @override
  Future<List<Map<String, dynamic>>> getList(String key) async {
    var res = <Map<String, dynamic>>[];

    final str = getKV(key);
    if (str != null) {
      final l = jsonDecode(str);
      res = (l as List)
          .map(
            (i) => Map<String, dynamic>.from(i as Map<String, dynamic>),
          )
          .toList();
    }
    return res;
  }

  @override
  Future<void> addItemToList(String key, Map<String, dynamic> acc) async {
    final ls = await getList(key);
    ls.add(acc);
    await setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> removeItemFromList(
    String key,
    String itemKey,
    String itemValue,
  ) async {
    final ls = await getList(key);
    ls.removeWhere((item) => item[itemKey] == itemValue);
    await setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> updateItemInList(
    String key,
    String itemKey,
    String? itemValue,
    Map<String, dynamic> itemNew,
  ) async {
    final ls = await getList(key);
    ls
      ..removeWhere((item) => item[itemKey] == itemValue)
      ..add(itemNew);
    await setKV(key, jsonEncode(ls));
  }

  @override
  Future<void> setListString(String key, List<String> value) async {
    await storage.setStringList(key: key, value: value);
  }

  @override
  List<String>? getListString(String key) {
    return storage.getStringList(key);
  }
}
