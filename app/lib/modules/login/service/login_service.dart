import 'package:ew_storage/ew_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import 'package:encointer_wallet/service/service.dart';
import 'package:encointer_wallet/config/biometric_auth_state.dart';

@immutable
final class LoginService with GetPin {
  const LoginService(this.localAuthentication, this.preferences, this.secureStorage);

  final LocalAuthentication localAuthentication;
  final SharedPreferences preferences;
  final SecureStorage secureStorage;

  static const biometricAuthStateKey = 'biometric-auth-state';
  static const oldBiometricAuthStateKey = 'biometric-auth-enabled';
  static const pinStorageKey = 'pin-key';

  BiometricAuthState? get getBiometricAuthState {
    final biometricAuthState = preferences.getString(biometricAuthStateKey);
    if (biometricAuthState != null) return BiometricAuthState.fromString(biometricAuthState);

    // See if we had set a state in earlier app versions
    final biometricAuthenticationEnabledOld = preferences.getBool(oldBiometricAuthStateKey);
    if (biometricAuthenticationEnabledOld == null) return null;

    // migrate old storage to new one and return state
    final biometricAuthStateOld = switch (biometricAuthenticationEnabledOld) {
      true => BiometricAuthState.enabled,
      false => BiometricAuthState.disabled,
    };

    // migrate the old storage to the new one
    setBiometricAuthState(biometricAuthStateOld);
    // clear the old storage
    preferences.remove(oldBiometricAuthStateKey);

    return biometricAuthStateOld;
  }

  Future<void> setBiometricAuthState(BiometricAuthState biometricAuthState) async {
    await preferences.setString(biometricAuthStateKey, biometricAuthState.name);
  }

  @override
  Future<String?> getPin() => secureStorage.read(key: pinStorageKey);

  Future<void> setPin(String pin) async {
    await secureStorage.write(key: pinStorageKey, value: pin);
  }

  Future<void> deleteAuthenticationData() {
    return Future.wait([
      secureStorage.delete(key: pinStorageKey),
      preferences.remove(oldBiometricAuthStateKey),
      preferences.remove(biometricAuthStateKey),
    ]);
  }

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
  ///
  /// [localizedReason] is the message displayed to the user during the authentication prompt.
  ///
  /// Might throw a `PlatformException` if there were technical problems.
  Future<bool> localAuthenticate(String localizedReason, [bool stickyAuth = false]) {
    try {
      return localAuthentication.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(useErrorDialogs: false, stickyAuth: stickyAuth),
      );
    } catch (e, s) {
      Log.e('$e', 'LoginService', s);
      rethrow;
    }
  }
}

mixin GetPin {
  Future<String?> getPin();
}
