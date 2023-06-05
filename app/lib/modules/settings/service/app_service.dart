import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  const AppService(this.storage);

  final SharedPreferences storage;

  static const String localStorageLocaleKey = 'locale';
  static const String enableBiometricAuthKey = 'biometric-auth-enabled';

  Locale init() {
    final code = storage.getString(localStorageLocaleKey);
    if (code != null) {
      return Locale(code);
    } else {
      // ignore: deprecated_member_use
      final deviceLocal = window.locale.languageCode;
      if (deviceLocal == 'en' || deviceLocal == 'de' || deviceLocal == 'ru' || deviceLocal == 'fr') {
        return Locale(deviceLocal);
      } else {
        return const Locale('en');
      }
    }
  }

  Future<Locale> setLocale(String languageCode) async {
    await storage.remove(localStorageLocaleKey);
    await storage.setString(localStorageLocaleKey, languageCode);
    return Locale(languageCode);
  }

  Future<void> setIsBiometricAuthenticationEnabled(bool value) async {
    await storage.setBool(enableBiometricAuthKey, value);
  }

  bool? getIsBiometricAuthenticationEnabled() => storage.getBool(enableBiometricAuthKey);

  String getLocaleName(String code) {
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
