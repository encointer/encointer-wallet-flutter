import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  const AppService(this.storage);

  final SharedPreferences storage;

  static const String localStorageLocaleKey = 'locale';
  static const String authenticationEnabled = 'authentication-enabled';

  Locale init() {
    final code = storage.getString(localStorageLocaleKey);
    if (code != null) {
      return Locale(code);
    } else {
      final deviceLocal = window.locale.languageCode;
      if (deviceLocal == 'en' || deviceLocal == 'de' || deviceLocal == 'ru' || deviceLocal == 'fr') {
        return Locale(deviceLocal);
      } else {
        return const Locale('en');
      }
    }
  }

  Future<Locale> setLocale(int index, List<Locale> locales) async {
    await storage.remove(localStorageLocaleKey);
    await storage.setString(localStorageLocaleKey, locales[index].languageCode);
    return locales[index];
  }

  Future<void> toggleAuthentication(bool value) async {
    await storage.setBool(authenticationEnabled, value);
  }

  bool? getAuthenticationEnabled() => storage.getBool(authenticationEnabled);

  String getName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutch';
      case 'fr':
        return 'Français';
      case 'ru':
        return 'Русский';
      default:
        return '';
    }
  }
}
