// ignore_for_file: library_private_types_in_public_api

import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/log/log_service.dart';

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
  Future<bool> authenticate(String localizedReason) {
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

  @action
  bool checkPinCode(String cachedPin) {
    final pass = pincode.map((e) => e.toString()).join();
    if (cachedPin.isNotEmpty && pass == cachedPin) return true;
    pincode.clear();
    return false;
  }
}
