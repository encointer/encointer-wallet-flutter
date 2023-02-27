import 'package:ew_storage/src/interface/exception.dart';

/// A Dart StorageInterface Client Interface
abstract class StorageInterfaceSyncRead {
  /// Returns the value associated with the provided [key].
  ///
  /// Returns `null` if no value is found for the given [key].
  ///
  /// Throws a [StorageException] if the read fails.
  String? readString({required String key});

  bool? readBool({required String key});

  double? readDouble({required String key});

  int? readInt({required String key});

  List<String>? readStringList({required String key});

  /// Asynchronously writes the provided [key] and [value] pair.
  ///
  /// Throws a [StorageException] if the write fails.
  Future<bool> writeString({required String key, required String value});

  Future<bool> writeBool({required String key, required bool value});

  Future<bool> writeDouble({required String key, required double value});

  Future<bool> writeInt({required String key, required int value});

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
