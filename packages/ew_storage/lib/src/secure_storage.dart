import 'package:ew_storage/src/interface/exception.dart';
import 'package:ew_storage/src/interface/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A Secure Storage client which implements the base [EwStorage] interface.
/// [SecureStorage] uses `FlutterSecureStorage` internally.
///
/// ```dart
/// // Create a `SecureStorage` instance.
/// final storage = const SecureStorage();
///
/// // Write a key/value pair.
/// await storage.write(key: 'my_key', value: 'my_value');
///
/// // Read value for key.
/// final value = await storage.read(key: 'my_key'); // 'my_value'
/// ```
class SecureStorage implements EwStorage {
  const SecureStorage([
    this._secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  ]);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> readAsync({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _secureStorage.deleteAll();
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @Deprecated('This mehtod should use by preferance storage')
  @override
  String? read({required String key}) => throw UnimplementedError();
}
