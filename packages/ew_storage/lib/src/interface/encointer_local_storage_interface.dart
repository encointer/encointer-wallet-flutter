import 'package:ew_storage/src/interface/storage_interface_sync_read.dart';
import 'package:flutter/material.dart';

abstract class EncointerLocalStorageInterface {
  const EncointerLocalStorageInterface(this.storage);

  final StorageInterfaceSyncRead storage;

  List<Map<String, dynamic>> getList(String key);

  List<Map<String, dynamic>> getAccountList();

  String? getCurrentAccount();

  Map<String, dynamic>? getSeeds(String seedType);

  Object? getAccountCache(String? accPubKey, String key);

  List<Map<String, dynamic>> getContactList();

  Object? getObject(String key);

  Map<String, dynamic>? getMap(String key);

  String? getKV(String key);

  List<String>? getShownMessages();

  Locale? getLocale();

  List<String>? getListString(String key);

  bool isBiometricEnabled();

  // --------------- set -----------

  Future<void> addAccount(Map<String, dynamic> acc);

  Future<bool> setCurrentAccount(String pubKey);

  Future<void> addContact(Map<String, dynamic> contact);

  Future<void> updateContact(Map<String, dynamic> con);

  Future<bool> setObject(String key, Object value);

  Future<void> setKV(String key, String value);

  Future<void> setAccountCache(String accPubKey, String key, Object? value);

  Future<bool> setShownMessages(List<String> value);

  Future<bool> setLocale(Locale? value);

  Future<bool> setBiometricEnabled({required bool value});

  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew);

  Future<void> setListString(String key, List<String> value);

  Future<void> addItemToList(String key, Map<String, dynamic> acc);

  // ------------ remove ------------

  Future<void> removeAccount(String pubKey);

  Future<void> removeContact(String address);

  Future<bool> removeKey(String key);

  Future<bool> clear();

  Future<void> removeItemFromList(String key, String itemKey, String itemValue);
}
