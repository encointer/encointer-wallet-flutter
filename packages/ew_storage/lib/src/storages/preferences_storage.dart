import 'package:ew_storage/src/storages/storage_exception.dart';
import 'package:ew_storage/src/storages/interface/sync_read_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A PreferencesStorage client which implements the base [SyncReadStorageInterface].
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
class PreferencesStorage implements SyncReadStorageInterface {
  const PreferencesStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Returns a new instance of [PreferencesStorage].
  ///
  /// If [SharedPreferences] is not provided, the default instance will be used.
  static Future<PreferencesStorage> getInstance([SharedPreferences? pref]) async {
    return PreferencesStorage._(pref ?? await SharedPreferences.getInstance());
  }

  @override
  String? getString(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  bool? getBool(String key) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  double? getDouble(String key) {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  int? getInt(String key) {
    try {
      return _sharedPreferences.getInt(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  List<String>? getStringList(String key) {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> setString({required String key, required String value}) {
    try {
      return _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> setBool({required String key, required bool value}) {
    try {
      return _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> setDouble({required String key, required double value}) {
    try {
      return _sharedPreferences.setDouble(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> setInt({required String key, required int value}) {
    try {
      return _sharedPreferences.setInt(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> setStringList({required String key, required List<String> value}) {
    try {
      return _sharedPreferences.setStringList(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      return _sharedPreferences.remove(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<bool> clear() {
    try {
      return _sharedPreferences.clear();
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }
}
