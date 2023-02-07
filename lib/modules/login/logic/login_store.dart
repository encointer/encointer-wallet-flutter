// ignore_for_file: library_private_types_in_public_api

import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/account_api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  _LoginStoreBase(this.localAuth, this.accountApi);

  final LocalAuthentication localAuth;
  final AccountApi accountApi;

  @observable
  bool isLoading = false;

  final pincode = ObservableList<int>();

  @action
  void addPin(int value) {
    if (pincode.length < 20 && !isLoading) pincode.add(value);
  }

  @action
  void removeLast() {
    if (pincode.isNotEmpty && !isLoading) pincode.removeLast();
  }

  Future<bool> authinticate() async {
    try {
      final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(useErrorDialogs: false),
      );
      return didAuthenticate;
    } catch (e, s) {
      Log.e('$e', 'SplashViewState', s);
      return false;
    }
  }

  Future<bool> isDeviceSupported() async {
    try {
      final isDeviceSupported = await localAuth.isDeviceSupported();
      return isDeviceSupported;
    } catch (e, s) {
      Log.e('$e', 'SplashViewState', s);
      return false;
    }
  }

  @action
  Future<bool> checkAccountPassword(AccountData account) async {
    isLoading = true;
    final pass = pincode.map((e) => e.toString()).join();
    final value = await accountApi.checkAccountPassword(account, pass);
    isLoading = false;
    if (value != null && value['success'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
