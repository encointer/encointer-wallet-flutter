import 'dart:convert';
import 'dart:ui';

import 'package:encointer_wallet/common/services/preferences/pref_storage.dart';
import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // TODO: implement addItemToList
    throw UnimplementedError();
  }

  @override
  Future<bool> clear() {
    return Future.value(true);
  }

  @override
  Future<List<Map<String, dynamic>>> getList(String key) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getListString(String key) {
    // TODO: implement getListString
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
    // TODO: implement getShownMessages
    throw UnimplementedError();
  }

  @override
  bool isBiometricEnabled() {
    // TODO: implement isBiometricEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> removeItemFromList(String key, String itemKey, String itemValue) {
    // TODO: implement removeItemFromList
    throw UnimplementedError();
  }

  @override
  Future<void> setAccountCache(String? accPubKey, String key, Object? value) async {
    var data = await getObject(key) as Map?;
    data ??= {};
    data[accPubKey] = value;
    await setObject(key, data);
  }

  @override
  Future<bool> setBiometricEnabled(bool? value) {
    // TODO: implement setBiometricEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> setListString(String key, List<String> value) {
    // TODO: implement setListString
    throw UnimplementedError();
  }

  @override
  Future<bool> setLocale(Locale? value) {
    // TODO: implement setLocale
    throw UnimplementedError();
  }

  @override
  Future<bool> setShownMessages(List<String> value) {
    // TODO: implement setShownMessages
    throw UnimplementedError();
  }

  @override
  Future<void> updateItemInList(
    String key,
    String itemKey,
    String? itemValue,
    Map<String, dynamic> itemNew,
  ) {
    // TODO: implement updateItemInList
    throw UnimplementedError();
  }

  @override
  Future<bool> setSeeds(String seedType, Map value) {
    return Future.value(true);
  }
}
