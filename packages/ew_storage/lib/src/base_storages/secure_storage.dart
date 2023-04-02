import 'package:ew_storage/src/base_storages/interface/secure_storage_interface.dart';
import 'package:ew_storage/src/base_storages/storage_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A SecureStorage client which implements the base [SecureStorageInterface].
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
class SecureStorage implements SecureStorageInterface {
  const SecureStorage([
    this._secureStorage = const FlutterSecureStorage(
      /// If you want read about [encryptedSharedPreferences]
      /// https://github.com/mogol/flutter_secure_storage/issues/487#issuecomment-1346244368
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  ]);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> read({required String key}) {
    try {
      return _secureStorage.read(key: key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> write({required String key, required String value}) {
    try {
      return _secureStorage.write(key: key, value: value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) {
    try {
      return _secureStorage.delete(key: key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> clear() {
    try {
      return _secureStorage.deleteAll();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}
