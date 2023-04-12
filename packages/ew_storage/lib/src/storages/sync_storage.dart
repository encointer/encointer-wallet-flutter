import 'dart:convert';
import 'dart:core';

import 'package:flutter/foundation.dart';

import 'package:ew_storage/src/storages/interface/sync_read_storage_interface.dart';

abstract class SyncStorage<Storage extends SyncReadStorageInterface> {
  const SyncStorage(this.storage);

  final Storage storage;

  // ----------- base methods --------------
  String? getString(String key) => storage.getString(key);

  Future<void> setString({required String key, required String value}) {
    return storage.setString(key: key, value: value);
  }

  bool? getBool(String key) => storage.getBool(key);

  Future<void> setBool({required String key, required bool value}) {
    return storage.setBool(key: key, value: value);
  }

  int? getInt(String key) => storage.getInt(key);

  Future<void> setInt({required String key, required int value}) {
    return storage.setInt(key: key, value: value);
  }

  double? getDouble(String key) => storage.getDouble(key);

  Future<void> setDouble({required String key, required double value}) {
    return storage.setDouble(key: key, value: value);
  }

  List<String>? getListString(String key) => storage.getStringList(key);

  Future<void> setListString({required String key, required List<String> value}) {
    return storage.setStringList(key: key, value: value);
  }

  T? getValueJsonDecode<T>(String key) {
    final value = storage.getString(key);
    return (value != null) ? jsonDecode(value) as T : null;
  }

  Future<void> setValueJsonEncode<T>(String key, T value) {
    return storage.setString(key: key, value: jsonEncode(value));
  }

  Future<T?> getValueJsonDecodeCompute<T>(String key) async {
    final strValue = storage.getString(key);
    final value = strValue != null ? await compute(jsonDecode, strValue) : null;
    return value as T?;
  }

  Future<void> setValueJsonEncodeCompute<T>({required String key, required T value}) async {
    final str = await compute(jsonEncode, value);
    await storage.setString(key: key, value: str);
  }

  Future<void> addItemToList({required String key, required Map<String, dynamic> newItem}) async {
    final ls = (await getValueJsonDecodeCompute<List<Map<String, dynamic>>>(key) ?? [])..add(newItem);
    return setValueJsonEncodeCompute<List<Map<String, dynamic>>>(key: key, value: ls);
  }

  Future<void> removeItemFromList({
    required String key,
    required String itemKey,
    required String itemValue,
  }) async {
    final ls = (await getValueJsonDecodeCompute<List<Map<String, dynamic>>>(key) ?? [])
      ..removeWhere((item) => item[itemKey] == itemValue);
    return setValueJsonEncodeCompute<List<Map<String, dynamic>>>(key: key, value: ls);
  }

  Future<void> updateItemInList({
    required String key,
    required String itemKey,
    required Map<String, dynamic> itemNew,
    String? itemValue,
  }) async {
    final ls = (await getValueJsonDecodeCompute<List<Map<String, dynamic>>>(key) ?? [])
      ..removeWhere((item) => item[itemKey] == itemValue)
      ..add(itemNew);
    return setValueJsonEncodeCompute<List<Map<String, dynamic>>>(key: key, value: ls);
  }

  Future<void> removeKey(String key) => storage.delete(key);

  Future<bool> clear() => storage.clear();
}
