// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/config/biometiric_auth_state.dart';
import 'package:encointer_wallet/modules/login/service/login_service.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase(this.loginService);

  final LoginService loginService;

  String cachedPin = '';

  @observable
  BiometricAuthState? biometricAuthState;

  @observable
  bool loading = false;

  Future<String> getPin() async {
    if (cachedPin.isEmpty) cachedPin = await loginService.getPin() ?? '';
    return cachedPin;
  }

  Future<void> setPin(String pin) async {
    cachedPin = pin;
    await loginService.setPin(pin);
  }

  Future<void> clearPin() async {
    cachedPin = '';
    await loginService.clearPin();
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

  Future<bool> localAuthenticate(String localizedReason) {
    return loginService.localAuthenticate(localizedReason);
  }
}
