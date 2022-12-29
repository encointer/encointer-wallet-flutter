import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LangService {
  const LangService(this.storage);

  final SharedPreferences storage;

  static const String localStorageLocaleKey = 'locale';

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
