import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:encointer_wallet/common/services/preferences/pref_storage.dart';

import 'package:encointer_wallet/extras/utils/extensions/string/string_extensions.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tag = 'preferences_service';

class PreferencesService extends PreferencesStorage {
  PreferencesService._();

  static PreferencesService instance = PreferencesService._();

  late final SharedPreferences _prefs;

  /// to check if biometrics is enabled or not
  static const _biometricEnabledKey = 'BIOMETRIC_ENABLED';
  static const defaultBiometricEnabled = false;

  /// Localization key
  static const String _localKey = 'locale';

  /// To check if user logged in or not
  static const userLoggedKey = 'USER_LOGGED';
  static const defaultUserLogged = false;

  static const accountsKey = 'wallet_account_list';
  static const currentAccountKey = 'wallet_current_account';
  static const encointerCommunityKey = 'wallet_encointer_community';
  static const contactsKey = 'wallet_contact_list';
  static const seedKey = 'wallet_seed';
  static const customKVKey = 'wallet_kv';
  static const meetUpNotificationKey = 'meet_up_notification';

  Future<void> init() async {
    Log.d('init', _tag);

    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getKV(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<bool> setKV(String key, String value) async {
    return _prefs.setString(key, value);
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

  Future<bool> setChosenCid(CommunityIdentifier cid) async {
    return setKV(encointerCommunityKey, cid.toString());
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
  Future<bool> setSeeds(String seedType, Map value) async {
    return setKV('${seedKey}_$seedType', jsonEncode(value));
  }

  @override
  Future<Map<String, dynamic>> getSeeds(String seedType) async {
    final value = await getKV('${seedKey}_$seedType');
    if (value != null) {
      return jsonDecode(value) as Map<String, dynamic>;
    }
    return {};
  }

  @override
  Future<bool> setObject(String key, Object value) async {
    final str = await compute(jsonEncode, value);
    return setKV('${customKVKey}_$key', str);
  }

  @override
  Future<Object?> getObject(String key) async {
    final value = await getKV('${customKVKey}_$key');
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

  /// Gets the more specific return type that `GetObject. This should always be preferred.
  ///
  /// Should be used instead of `getObject`, see #533.
  @override
  Future<Map<String, dynamic>?> getMap(String key) async {
    final value = await getKV('${customKVKey}_$key');

    if (value != null) {
      // String to `Map<String, dynamic>` conversion
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
  Future<List<String>> getShownMessages() async {
    return getListString(meetUpNotificationKey);
  }

  @override
  Future<bool> setLocale(Locale? value) {
    return _prefs.setString(_localKey, value?.languageCode ?? 'en');
  }

  @override
  Future<Locale>? getLocale() {
    final locale = _prefs.getString(_localKey);
    if (locale.isNullOrEmpty) return null;

    return Future.value(Locale(locale!));
  }

  @override
  Future<bool> setBiometricEnabled(bool? value) {
    return _prefs.setBool(_biometricEnabledKey, value ?? false);
  }

  @override
  bool isBiometricEnabled() {
    return _prefs.getBool(_biometricEnabledKey) ?? defaultBiometricEnabled;
  }

  @override
  Future<bool> clear() async {
    return _prefs.clear();
  }

  @override
  Future<List<Map<String, dynamic>>> getList(String key) async {
    var res = <Map<String, dynamic>>[];

    final str = await getKV(key);
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
    await _prefs.setStringList(key, value);
  }

  @override
  Future<List<String>> getListString(String key) async {
    return _prefs.getStringList(key) ?? <String>[];
  }
}
