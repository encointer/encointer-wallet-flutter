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

  @action
  void addPinCode(int value) {
    if (pincode.length < 20 && !isLoading) pincode.add(value);
  }

  @action
  void removeLastPinCode() {
    if (pincode.isNotEmpty && !isLoading) pincode.removeLast();
  }

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

  Future<bool> isDeviceSupported() {
    try {
      return _localAuth.isDeviceSupported();
    } catch (e, s) {
      Log.e('$e', 'SplashViewState', s);
      return Future.value(false);
    }
  }

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
