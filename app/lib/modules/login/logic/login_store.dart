// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/config/biometric_auth_state.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase(this.loginService);

  final LoginService loginService;

  String? cachedPin;

  @observable
  BiometricAuthState? biometricAuthState;

  @observable
  bool loading = false;

  /// If the user has already authenticated this session, true will be returned.
  /// if not, the user will be asked to authenticate with PIN or biometric depending on the
  /// settings.
  FutureOr<bool> ensureAuthenticated(BuildContext context) async {
    if (cachedPin != null) return true;
    await LoginDialog.verifyPinOrBioAuth(context);
    return cachedPin != null;
  }

  /// Persists the new PIN in the secure storage.
  ///
  /// Attention: This function must be called *exclusively* upon:
  /// * Setting the PIN initially
  /// * Changing the PIN
  Future<void> persistNewPin(String pin) async {
    cachedPin = pin;
    await loginService.persistPin(pin);
  }

  Future<bool> isValid(String input) async {
    final storedPin = cachedPin ?? await loginService.getPin();
    return storedPin == input.trim();
  }

  Future<void> deleteAuthenticationData() async {
    cachedPin = null;
    await loginService.deleteAuthenticationData();
  }

  @computed
  BiometricAuthState? get getBiometricAuthState {
    return biometricAuthState ??= loginService.getBiometricAuthState;
  }

  @action
  Future<void> setBiometricAuthState(BiometricAuthState value) async {
    biometricAuthState = value;
    await loginService.setBiometricAuthState(value);
  }

  Future<bool> isDeviceSupported() {
    return loginService.isDeviceSupported();
  }

  /// Might throw a `PlatformException` if there were technical problems.
  Future<bool> localAuthenticate(String localizedReason, [bool stickyAuth = false]) {
    try {
      return loginService.localAuthenticate(localizedReason, stickyAuth);
    } catch (e) {
      rethrow;
    }
  }
}
