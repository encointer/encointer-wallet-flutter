import 'package:encointer_wallet/common/services/preferences/pref_storage.dart';
import 'package:flutter/material.dart';

class LocalData {
  LocalData(this._storage);

  /// MockLocalStorage
  /// PreferencesService
  final PreferencesStorage _storage;

  Future<List<Map<String, dynamic>>> getAccountList() {
    return _storage.getAccountList();
  }

  Future<void> addAccount(Map<String, dynamic> acc) async {
    await _storage.addAccount(acc);
  }

  Future<void> removeAccount(String pubKey) async {
    await _storage.removeAccount(pubKey);
  }

  Future<bool> setCurrentAccount(String pubKey) async {
    return _storage.setCurrentAccount(pubKey);
  }

  Future<String?> getCurrentAccount() async {
    return _storage.getCurrentAccount();
  }

  Future<Map<String, dynamic>> getSeeds(String seedType) async {
    return _storage.getSeeds(seedType);
  }

  Future<Object?> getAccountCache(String? accPubKey, String key) async {
    return _storage.getAccountCache(accPubKey, key);
  }

  Future<List<Map<String, dynamic>>> getContactList() async {
    return _storage.getContactList();
  }

  Future<void> addContact(Map<String, dynamic> contact) async {
    await _storage.addContact(contact);
  }

  Future<void> removeContact(String address) async {
    await _storage.removeContact(address);
  }

  Future<void> updateContact(Map<String, dynamic> con) async {
    await _storage.updateContact(con);
  }

  Future<Object?> getObject(String key) async {
    return _storage.getObject(key);
  }

  Future<bool> setObject(String key, Object value) async {
    return _storage.setObject(key, value);
  }

  Future<bool> removeKey(String key) async {
    return _storage.removeKey(key);
  }

  Future<Map<String, dynamic>?> getMap(String key) async {
    return _storage.getMap(key);
  }

  Future<String?> getKV(String key) {
    return _storage.getKV(key);
  }

  Future<void> setKV(String key, String value) async {
    await _storage.setKV(key, value);
  }

  Future<void> setAccountCache(String? accPubKey, String key, Object? value) async {
    await _storage.setAccountCache(accPubKey, key, value);
  }

  Future<bool> setShownMessages(List<String> value) async {
    return _storage.setShownMessages(value);
  }

  Future<List<String>> getShownMessages() async {
    return _storage.getShownMessages();
  }

  Future<bool> setLocale(Locale? value) async {
    return _storage.setLocale(value);
  }

  Future<Locale>? getLocale() {
    return _storage.getLocale();
  }

  Future<bool> setBiometricEnabled(bool? value) async {
    return _storage.setBiometricEnabled(value);
  }

  bool isBiometricEnabled() {
    return _storage.isBiometricEnabled();
  }

  Future<bool> clear() async {
    return _storage.clear();
  }

  Future<List<Map<String, dynamic>>> getList(String key) async {
    return _storage.getList(key);
  }

  Future<void> addItemToList(String key, Map<String, dynamic> acc) async {
    await _storage.addItemToList(key, acc);
  }

  Future<void> removeItemFromList(
    String key,
    String itemKey,
    String itemValue,
  ) async {
    await _storage.removeItemFromList(key, itemKey, itemValue);
  }

  Future<void> updateItemInList(
    String key,
    String itemKey,
    String? itemValue,
    Map<String, dynamic> itemNew,
  ) async {
    await _storage.updateItemInList(key, itemKey, itemValue, itemNew);
  }

  Future<void> setListString(String key, List<String> value) async {
    await _storage.setListString(key, value);
  }

  Future<List<String>> getListString(String key) async {
    return _storage.getListString(key);
  }

  Future<bool> setSeeds(String seedType, Map value) async {
    return _storage.setSeeds(seedType, value);
  }
}
