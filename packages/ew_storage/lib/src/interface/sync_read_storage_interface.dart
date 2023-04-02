import 'package:ew_storage/src/interface/storage_exception.dart';

/// A Dart StorageInterface Client Interface
abstract class SyncReadStorageInterface {
  /// Returns the [String] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the get fails.
  String? getString(String key);

  /// Returns the [bool] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the get fails.
  bool? getBool(String key);

  /// Returns the [double] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the get fails.
  double? getDouble(String key);

  /// Returns the [int] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the get fails.
  int? getInt(String key);

  /// Returns the [List<String>] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the get fails.
  List<String>? getStringList(String key);

  /// Asynchronously sets [String] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the set fails.
  Future<bool> setString({required String key, required String value});

  /// Asynchronously sets [bool] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the set fails.
  Future<bool> setBool({required String key, required bool value});

  /// Asynchronously sets [double] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the set fails.
  Future<bool> setDouble({required String key, required double value});

  /// Asynchronously sets [int] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the set fails.
  Future<bool> setInt({required String key, required int value});

  /// Asynchronously sets [List<String>] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the set fails.
  Future<bool> setStringList({required String key, required List<String> value});

  /// Asynchronously removes the value associated with the provided [key].
  ///
  /// Throws a [StorageException] if the deletion fails.
  Future<bool> delete(String key);

  /// Asynchronously removes all 'key-value' pairs.
  ///
  /// Throws a [StorageException] if the deletion fails.
  Future<bool> clear();
}
