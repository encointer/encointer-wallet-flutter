// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';

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
 
  bool _checkPinCode(String cachedPin) {
    final pass = pinCode.map((e) => e.toString()).join();
    if (cachedPin.isNotEmpty && pass == cachedPin) return true;
    pinCode.clear();
    return false;
  }

  bool usePincodeAuth(BuildContext context) {
    final appStore = context.read<AppStore>();
    return _checkPinCode(appStore.settings.cachedPin);
  }

  Future<void> checkCachedPin(BuildContext context) async {
    final appStore = context.read<AppStore>();
    await AppAlert.showPasswordInputDialog(
      context,
      account: appStore.account.currentAccount,
      onSuccess: appStore.settings.setPin,
      canPop: false,
    );
  }
}
