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

  FutureOr<String?> getPin(BuildContext context) async {
    if (cachedPin != null) return cachedPin!;
    await LoginDialog.verifyPinOrBioAuth(
      context,
      onSuccess: (v) async => cachedPin = await loginService.getPin(),
    );
    return cachedPin;
  }

  Future<void> setPin(String pin) async {
    cachedPin = pin;
    await loginService.setPin(pin);
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
