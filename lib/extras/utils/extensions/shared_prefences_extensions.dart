import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesEx on SharedPreferences {
  Future<bool> setBoolSafe(String key, bool? value) {
    if (value == null) {
      return remove(key);
    } else {
      return setBool(key, value);
    }
  }

  Future<bool> setIntSafe(String key, int? value) {
    if (value == null) {
      return remove(key);
    } else {
      return setInt(key, value);
    }
  }

  Future<bool> setStringSafe(String key, String? value) {
    if (value == null) {
      return remove(key);
    } else {
      return setString(key, value);
    }
  }

  Future<bool> setStringListSafe(String key, List<String>? value) {
    if (value == null) {
      return remove(key);
    } else {
      return setStringList(key, value);
    }
  }
}
