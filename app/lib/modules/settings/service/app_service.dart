import 'dart:ui';

import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppService {
  const AppService(this.storage);

  final SharedPreferences storage;

  static const String localStorageLocaleKey = 'locale';
  static const String biometricAuthStateKey = 'biometric-auth-state';

  Locale get getLocale {
    final code = storage.getString(localStorageLocaleKey);
    if (code != null) return Locale(code);
    // ignore: deprecated_member_use
    final deviceLocal = Locale(window.locale.languageCode);
    return AppLocalizations.delegate.isSupported(deviceLocal) ? deviceLocal : const Locale('en');
  }

  Future<Locale> setLocale(String languageCode) async {
    await storage.remove(localStorageLocaleKey);
    await storage.setString(localStorageLocaleKey, languageCode);
    return Locale(languageCode);
  }

  BiometricAuthState? get getBiometricAuthState {
    final biometricAuthState = storage.getString(biometricAuthStateKey);
    return biometricAuthState != null ? BiometricAuthState.fromString(biometricAuthState) : null;
  }

  Future<void> setBiometricAuthState(BiometricAuthState biometricAuthState) async {
    await storage.setString(biometricAuthStateKey, biometricAuthState.name);
  }
}
