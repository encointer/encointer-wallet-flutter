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
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> write<T>({required String key, required T value}) async {
    try {
      if (value is String) {
        await _secureStorage.write(key: key, value: value);
      } else {
        throw StorageException('${value.runtimeType} is not subtype of String');
      }
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

  @Deprecated('This mehtod should use by preferance storage')
  @override
  T? read<T>({required String key}) => throw UnimplementedError();
}
