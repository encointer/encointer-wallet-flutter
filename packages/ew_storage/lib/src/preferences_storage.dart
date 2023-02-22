import 'package:ew_storage/src/interface/exception.dart';
import 'package:ew_storage/src/interface/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Preferences Storage client which implements the base [EwStorage] interface.
/// [PreferencesStorage] uses `SharedPreferences` internally.
///
/// ```dart
/// // Create a `PreferencesStorage` instance.
/// final storage = await PreferencesStorage.getInstance();
///
/// // Write a key/value pair.
/// await storage.write(key: 'my_key', value: 'my_value');
///
/// // Read value for key.
/// final value = await storage.read(key: 'my_key'); // 'my_value'
/// ```
class PreferencesStorage implements EwStorage {
  const PreferencesStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static Future<PreferencesStorage> getInstance([SharedPreferences? pref]) async {
    return PreferencesStorage._(pref ?? await SharedPreferences.getInstance());
  }

  @override
  String? read({required String key}) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @Deprecated('This mehtod should use by secure storage')
  @override
  Future<String?> readAsync({required String key}) => throw UnimplementedError();
}
