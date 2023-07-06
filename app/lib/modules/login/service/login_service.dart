import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/config/biometiric_auth_state.dart';

@immutable
final class LoginService {
  const LoginService(this.localAuthentication, this.preferences, this.secureStorage);

  final LocalAuthentication localAuthentication;
  final SharedPreferences preferences;
  final SecureStorage secureStorage;

  static const isDeviceSupportKey = 'is-device-support-key';
  static const biometricAuthStateKey = 'biometric-auth-state';
  static const pinStorageKey = 'pin-key';

  BiometricAuthState? get getBiometricAuthState {
    final biometricAuthState = preferences.getString(biometricAuthStateKey);
    return biometricAuthState != null ? BiometricAuthState.fromString(biometricAuthState) : null;
  }

  Future<void> setBiometricAuthState(BiometricAuthState biometricAuthState) async {
    await preferences.setString(biometricAuthStateKey, biometricAuthState.name);
  }

  Future<String?> getPin() => secureStorage.read(key: pinStorageKey);

  Future<void> setPin(String pin) async {
    await secureStorage.write(key: pinStorageKey, value: pin);
  }

  Future<void> clearPin() => secureStorage.clear();

  /// Check if local authentication is supported on the device.
  /// Returns a `future` with `true` if supported, `false` otherwise.
  /// Returns `false` and logs errors if a `PlatformException` occurs.
  Future<bool> isDeviceSupported() async {
    try {
      return localAuthentication.isDeviceSupported();
    } catch (e, s) {
      Log.e('$e', 'LoginStore', s);
      return Future.value(false);
    }
  }

  /// Authenticates the user with biometrics or device authentication options available on the device.
  /// Returns a `Future<bool>` which is `true` if successful, `false` otherwise.
  /// [localizedReason] is the message displayed to the user during the authentication prompt.
  Future<bool> localAuthenticate(String localizedReason, [bool stickyAuth = false]) {
    try {
      return localAuthentication.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(useErrorDialogs: false, stickyAuth: stickyAuth),
      );
    } catch (e, s) {
      Log.e('$e', 'LoginStore', s);
      return Future.value(false);
    }
  }
}
