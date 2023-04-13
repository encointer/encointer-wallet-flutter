// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/page-encointer/home_page.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/modules/settings/logic/app_settings_store.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase(LocalAuthentication localAuth) : _localAuth = localAuth;

  final LocalAuthentication _localAuth;

  @observable
  bool isLoading = false;

  final pincode = ObservableList<int>();

  /// [addPinCode] is an action method that adds an integer value to the pincode list.
  /// If the length of the [pincode] list is less than 20 and the app is not in a `loading` state,
  @action
  void addPinCode(int value, int maxLength) {
    if (pincode.length < maxLength) pincode.add(value);
  }

  /// [removeLastDigit] is an action method that removes the last element from the [pincode] list
  /// if the list is not empty and [isLoading] is `false`.
  @action
  void removeLastDigit() {
    if (pincode.isNotEmpty && !isLoading) pincode.removeLast();
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
      Log.e('$e', 'SplashViewState', s);
      return Future.value(false);
    }
  }

  /// Check if local authentication is supported on the device.
  /// Returns a `future` with `true` if supported, `false` otherwise.
  /// Returns `false` and logs errors if a `PlatformException` occurs.
  Future<bool> isDeviceSupported() {
    try {
      return _localAuth.isDeviceSupported();
    } catch (e, s) {
      Log.e('$e', 'SplashViewState', s);
      return Future.value(false);
    }
  }

  bool checkPinCode(String cachedPin) {
    final pass = pincode.map((e) => e.toString()).join();
    if (cachedPin.isNotEmpty && pass == cachedPin) return true;
    pincode.clear();
    return false;
  }

  Future<void> navigate(BuildContext context, {required bool isPinCorrect, required Translations dic}) async {
    if (isPinCorrect) {
      await Navigator.pushNamedAndRemoveUntil(context, EncointerHomePage.route, (route) => false);
    } else {
      RootSnackBar.showMsg(dic.account.passwordError);
    }
  }

  Future<void> useBiometricAuth(BuildContext context) async {
    final appStore = context.read<AppStore>();
    if (appStore.settings.cachedPin.isEmpty) {
      await AppAlert.showPasswordInputDialog(context: context, account: appStore.account.currentAccount);
    }
    final dic = I18n.of(context)!.translationsForLocale();
    final loginStore = context.read<LoginStore>();
    final appSettingsStore = context.read<AppSettings>();
    if (await loginStore.isDeviceSupported() && appSettingsStore.getEnableBiometricAuth()) {
      final isPinCorrect = await loginStore.localAuthenticate(dic.account.localizedReason);
      await loginStore.navigate(context, isPinCorrect: isPinCorrect, dic: dic);
    }
  }

  Future<void> usePincodeAuth(BuildContext context) async {
    final dic = I18n.of(context)!.translationsForLocale();
    final loginStore = context.read<LoginStore>();
    final appStore = context.read<AppStore>();
    if (appStore.settings.cachedPin.isEmpty) {
      await AppAlert.showPasswordInputDialog(context: context, account: appStore.account.currentAccount);
    }
    final isPinCorrect = loginStore.checkPinCode(appStore.settings.cachedPin);
    await loginStore.navigate(context, isPinCorrect: isPinCorrect, dic: dic);
  }
}
