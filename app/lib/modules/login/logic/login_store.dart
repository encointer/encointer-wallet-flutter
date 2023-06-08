// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/l10n/l10.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase(LocalAuthentication localAuth) : _localAuth = localAuth;

  final LocalAuthentication _localAuth;

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

  /// Check if local authentication is supported on the device.
  /// Returns a `future` with `true` if supported, `false` otherwise.
  /// Returns `false` and logs errors if a `PlatformException` occurs.
  @action
  Future<bool> isDeviceSupported() async {
    try {
      return deviceSupportedBiometricAuth = await _localAuth.isDeviceSupported();
    } catch (e, s) {
      Log.e('$e', 'LoginStore', s);
      return Future.value(false);
    }
  }

  /// Authenticates the user with biometrics or device authentication options available on the device.
  /// Returns a `Future<bool>` which is `true` if successful, `false` otherwise.
  /// [localizedReason] is the message displayed to the user during the authentication prompt.
  Future<bool> localAuthenticate(String localizedReason) {
    try {
      return _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(useErrorDialogs: false),
      );
    } catch (e, s) {
      Log.e('$e', 'LoginStore', s);
      return Future.value(false);
    }
  }

  Future<void> useBiometricAuth(BuildContext context) async {
    if (deviceSupportedBiometricAuth) {
      final dic = context.l10n;
      final isPinCorrect = await localAuthenticate(dic.localizedReason);
      await _navigate(context, isPinCorrect: isPinCorrect, dic: dic);
    }
  }

  bool _checkPinCode(String cachedPin) {
    final pass = pinCode.map((e) => e.toString()).join();
    if (cachedPin.isNotEmpty && pass == cachedPin) return true;
    pinCode.clear();
    return false;
  }

  Future<void> usePincodeAuth(BuildContext context) async {
    final dic = context.l10n;
    final appStore = context.read<AppStore>();
    final isPinCorrect = _checkPinCode(appStore.settings.cachedPin);
    await _navigate(context, isPinCorrect: isPinCorrect, dic: dic);
  }

  Future<void> _navigate(BuildContext context, {required bool isPinCorrect, required AppLocalizations dic}) async {
    if (isPinCorrect) {
      await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
    } else {
      RootSnackBar.showMsg(dic.pinError);
    }
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
