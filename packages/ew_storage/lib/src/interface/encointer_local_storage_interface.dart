import 'package:ew_storage/src/interface/storage_interface_sync_read.dart';
import 'package:flutter/material.dart';

abstract class EncointerLocalStorageInterface {
  const EncointerLocalStorageInterface(this.storage);

  final StorageInterfaceSyncRead storage;

  // ----------- base methods --------------
  Map<String, dynamic>? getMap(String key);
  List<Map<String, dynamic>> getMapList(String key);
  List<String>? getListString(String key);

  Object? getObject(String key);
  Future<void> setObject(String key, Object value);

  String? getKV(String key);
  Future<void> setKV(String key, String value);

  Future<void> addItemToList(String key, Map<String, dynamic> acc);
  Future<void> removeItemFromList(String key, String itemKey, String itemValue);
  Future<void> updateItemInList(String key, String itemKey, String? itemValue, Map<String, dynamic> itemNew);

  Future<void> removeKey(String key);
  Future<void> clear();

  // ----------- account methods --------------
  String? getCurrentAccount();
  Future<void> setCurrentAccount(String pubKey);
  Future<void> removeAccount(String pubKey);

  List<Map<String, dynamic>> getAccountList();
  Future<void> addAccount(Map<String, dynamic> acc);

  Object? getAccountCache(String? accPubKey, String key);
  Future<void> setAccountCache(String accPubKey, String key, Object? value);

  // ----------- contact methods --------------
  List<Map<String, dynamic>> getContactList();

  Future<void> addContact(Map<String, dynamic> contact);
  Future<void> removeContact(String address);
  Future<void> updateContact(Map<String, dynamic> con);

  // ----------- community methods --------------
  Map<String, dynamic>? getSeeds(String seedType);

  // Check can we delete this method
  Future<bool> setLocale(Locale? value);
}
