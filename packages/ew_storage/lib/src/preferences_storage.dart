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
/// await storage.writeString(key: 'my_key', value: 'my_value');
///
/// // Read value for key.
/// final value = storage.readString(key: 'my_key'); // 'my_value'
/// ```
class PreferencesStorage implements EwStorage {
  const PreferencesStorage._(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  /// Returns a new instance of [PreferencesStorage].
  ///
  /// If [SharedPreferences] is not provided, the default instance will be used.
  static Future<PreferencesStorage> getInstance([SharedPreferences? pref]) async {
    return PreferencesStorage._(pref ?? await SharedPreferences.getInstance());
  }

  @Deprecated('Please use the `readString` method instead.')
  @override
  Future<String?> read({required String key}) async {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  String? readString({required String key}) {
    try {
      return _sharedPreferences.getString(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  bool? readBool({required String key}) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  double? readDouble({required String key}) {
    try {
      return _sharedPreferences.getDouble(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  int? readInt({required String key}) {
    try {
      return _sharedPreferences.getInt(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  List<String>? readStringList({required String key}) {
    try {
      return _sharedPreferences.getStringList(key);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  @override
  Future<void> writeString({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<void> writeBool({required String key, required bool value}) async {
    try {
      await _sharedPreferences.setBool(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<void> writeDouble({required String key, required double value}) async {
    try {
      await _sharedPreferences.setDouble(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<void> writeInt({required String key, required int value}) async {
    try {
      await _sharedPreferences.setInt(key, value);
    } catch (error, stackTrace) {
      throw StorageException(error, stackTrace);
    }
  }

  Future<void> writeStringList({required String key, required List<String> value}) async {
    try {
      await _sharedPreferences.setStringList(key, value);
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
}
