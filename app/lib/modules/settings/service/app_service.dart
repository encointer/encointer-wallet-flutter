import 'dart:ui';

import 'package:encointer_wallet/l10n/l10.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  const AppService(this.storage);

  final SharedPreferences storage;

  static const String localStorageLocaleKey = 'locale';
  static const String enableBiometricAuthKey = 'biometric-auth-enabled';

  Locale init() {
    final code = storage.getString(localStorageLocaleKey);
    if (code != null) return Locale(code);
    // ignore: deprecated_member_use
    final deviceLocal = window.locale;
    return AppLocalizations.delegate.isSupported(deviceLocal) ? deviceLocal : const Locale('en');
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
}
