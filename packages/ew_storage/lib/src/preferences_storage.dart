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
  T? read<T>({required String key}) {
    try {
      switch (T) {
        case String:
          return _sharedPreferences.getString(key) as T?;
        case bool:
          return _sharedPreferences.getBool(key) as T?;
        case double:
          return _sharedPreferences.getDouble(key) as T?;
        case int:
          return _sharedPreferences.getInt(key) as T?;
        case List<String>:
          return _sharedPreferences.getStringList(key) as T?;
        default:
          throw const StorageException('Type is not subtype of `String`, `bool`, `double`, `int`, `List<String>`');
      }
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> write<T>({required String key, required T value}) async {
    try {
      switch (value.runtimeType) {
        case String:
          await _sharedPreferences.setString(key, value as String);
          break;
        case bool:
          await _sharedPreferences.setBool(key, value as bool);
          break;
        case double:
          await _sharedPreferences.setDouble(key, value as double);
          break;
        case int:
          await _sharedPreferences.setInt(key, value as int);
          break;
        case List<String>:
          await _sharedPreferences.setStringList(key, value as List<String>);
          break;
        default:
          throw const StorageException('Type is not subtype of `String`, `bool`, `double`, `int`, `List<String>`');
      }
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
