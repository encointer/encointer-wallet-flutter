import 'package:ew_storage/src/interface/storage_exception.dart';

/// A Dart StorageInterface Client Interface
abstract class StorageInterfaceSyncRead {
  /// Returns the [String] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  String? readString({required String key});

  /// Returns the [bool] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  bool? readBool({required String key});

  /// Returns the [double] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  double? readDouble({required String key});

  /// Returns the [int] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  int? readInt({required String key});

  /// Returns the [List<String>] value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  List<String>? readStringList({required String key});

  /// Asynchronously writes [String] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the write fails.
  Future<bool> writeString({required String key, required String value});

  /// Asynchronously writes [bool] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the write fails.
  Future<bool> writeBool({required String key, required bool value});

  /// Asynchronously writes [double] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the write fails.
  Future<bool> writeDouble({required String key, required double value});

  /// Asynchronously writes [int] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the write fails.
  Future<bool> writeInt({required String key, required int value});

  /// Asynchronously writes [List<String>] the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the write fails.
  Future<bool> writeStringList({required String key, required List<String> value});

  /// Asynchronously removes the value associated with the provided [key].
  ///
  /// Throws a [StorageException] if the deletion fails.
  Future<bool> delete({required String key});

  /// Asynchronously removes all 'key-value' pairs.
  ///
  /// Throws a [StorageException] if the deletion fails.
  Future<bool> clear();
}
