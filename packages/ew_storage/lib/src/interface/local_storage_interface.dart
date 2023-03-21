import 'package:flutter/material.dart';

abstract class EncointerLocalStorage {
  Future<List<Map<String, dynamic>>> getAccountList();

  Future<void> addAccount(Map<String, dynamic> acc);

  Future<void> removeAccount(String pubKey);

  Future<bool> setCurrentAccount(String pubKey);

  Future<String?> getCurrentAccount();

  Map<String, dynamic>? getSeeds(String seedType);

  Future<Object?> getAccountCache(String? accPubKey, String key);

  Future<List<Map<String, dynamic>>> getContactList();

  Future<void> addContact(Map<String, dynamic> contact);

  Future<void> removeContact(String address);

  Future<void> updateContact(Map<String, dynamic> con);

  Future<Object?> getObject(String key);

  Future<bool> setObject(String key, Object value);

  Future<bool> removeKey(String key);

  Future<Map<String, dynamic>?> getMap(String key);

  String? getKV(String key);

  Future<void> setKV(String key, String value);

  Future<void> setAccountCache(String? accPubKey, String key, Object? value);

  Future<bool> setShownMessages(List<String> value);

  List<String>? getShownMessages();

  Future<bool> setLocale(Locale? value);

  Locale? getLocale();

  Future<bool> setBiometricEnabled({required bool value});

  bool isBiometricEnabled();

  Future<bool> clear();

  Future<List<Map<String, dynamic>>> getList(String key);

  Future<void> addItemToList(String key, Map<String, dynamic> acc);

  Future<void> removeItemFromList(
    String key,
    String itemKey,
    String itemValue,
  );

  Future<void> updateItemInList(
    String key,
    String itemKey,
    String? itemValue,
    Map<String, dynamic> itemNew,
  );

  Future<void> setListString(String key, List<String> value);

  List<String>? getListString(String key);
}
