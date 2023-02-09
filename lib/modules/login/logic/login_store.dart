// ignore_for_file: library_private_types_in_public_api

import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase(LocalAuthentication localAuth, AccountApi accountApi)
      : _localAuth = localAuth,
        _accountApi = accountApi;

  final LocalAuthentication _localAuth;
  final AccountApi _accountApi;

  @observable
  bool isLoading = false;

  final pincode = ObservableList<int>();

  /// [addPinCode] is an action method that adds an integer value to the pincode list.
  /// If the length of the [pincode] list is less than 20 and the app is not in a `loading` state,
  @action
  void addPinCode(int value) {
    if (pincode.length < 20 && !isLoading) pincode.add(value);
  }

  /// [removeLastPinCode] is an action method that removes the last element from the [pincode] list
  /// if the list is not empty and [isLoading] is `false`.
  @action
  void removeLastPinCode() {
    if (pincode.isNotEmpty && !isLoading) pincode.removeLast();
  }

  /// Authenticates the user with biometrics or device authentication options available on the device.
  /// Returns a `Future<bool>` which is `true` if successful, `false` otherwise.
  /// [localizedReason] is the message displayed to the user during the authentication prompt.
  Future<bool> authinticate(String localizedReason) {
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

  /// [checkAccountPassword] is an asynchronous action method that checks if the given password
  /// is correct for the given account. It returns a `future` that resolves to a boolean value
  /// indicating whether the password is correct or not.
  @action
  Future<bool> checkAccountPassword(AccountData account) async {
    isLoading = true;
    final pass = pincode.map((e) => e.toString()).join();
    final result = await _accountApi.checkAccountPassword(account, pass);
    pincode.clear();
    isLoading = false;
    return result?['success'] == true;
  }
}
