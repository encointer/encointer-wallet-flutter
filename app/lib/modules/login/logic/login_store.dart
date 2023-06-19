// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/store/app.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  bool deviceSupportedBiometricAuth = true;

  final pinCode = ObservableList<int>();

  @action
  void addDigit(int value, int maxLength) {
    if (pinCode.length < maxLength) pinCode.add(value);
  }

  @action
  void removeLastDigit() {
    if (pinCode.isNotEmpty) pinCode.removeLast();
  }

  @action
  bool usePincodeAuth(BuildContext context) {
    final cachedPin = context.read<AppStore>().settings.cachedPin;
    final pass = pinCode.map((e) => e.toString()).join();
    if (cachedPin.isNotEmpty && pass == cachedPin) return true;
    pinCode.clear();
    return false;
  }
}
