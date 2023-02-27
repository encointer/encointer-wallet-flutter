import 'package:ew_storage/src/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [PreferencesStorage] uses `SharedPreferences` internally.
///
/// ```dart
/// // Create a `PreferencesStorage` instance.
/// final storage = await PreferencesStorage.getInstance();
///
/// // Write a key/value pair.
/// await storage.setString(key: 'my_key', value: 'my_value');
///
/// // Read value for key.
/// final value = storage.getString(key: 'my_key'); // 'my_value'
/// ```
class PreferencesStorage {
  const PreferencesStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Returns a new instance of [PreferencesStorage].
  ///
  /// If [SharedPreferences] is not provided, the default instance will be used.
  static Future<PreferencesStorage> getInstance([SharedPreferences? pref]) async {
    return PreferencesStorage._(pref ?? await SharedPreferences.getInstance());
  }

  String? getString({required String key}) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  bool? getBool({required String key}) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  double? getDouble({required String key}) {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  int? getInt({required String key}) {
    try {
      return _sharedPreferences.getInt(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  List<String>? getStringList({required String key}) {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> setString({required String key, required String value}) {
    try {
      return _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> setBool({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> setDouble({required String key, required double value}) {
    try {
      return _sharedPreferences.setDouble(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> setInt({required String key, required int value}) {
    try {
      return _sharedPreferences.setInt(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> setStringList({required String key, required List<String> value}) {
    try {
      return _sharedPreferences.setStringList(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> remove({required String key}) async {
    try {
      return _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<bool> clear() {
    try {
      return _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}
