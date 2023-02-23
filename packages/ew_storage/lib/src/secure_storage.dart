import 'package:ew_storage/src/interface/exception.dart';
import 'package:ew_storage/src/interface/storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A Secure Storage client which implements the base [EwStorage] interface.
/// By default, [SecureStorage] uses `FlutterSecureStorage`.
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
  Future<String?> read({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> writeString({required String key, required String value}) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _secureStorage.deleteAll();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}
