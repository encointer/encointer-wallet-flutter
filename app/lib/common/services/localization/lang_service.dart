import 'dart:ui';

import 'package:encointer_wallet/common/services/preferences/local_data.dart';

class LangService {
  LangService(this._storage);

  static const enLocale = Locale('en', '');
  static const deLocale = Locale('de', '');
  static const frLocale = Locale('fr', '');
  static const ruLocale = Locale('ru', '');

  final LocalData _storage;

  /// Future<Locale> because of integration test
  Future<Locale> init() async {
    final code = await _storage.getLocale();
    if (code != null) {
      return Locale(code.languageCode);
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
    await _storage.setLocale(locales[index]);
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
