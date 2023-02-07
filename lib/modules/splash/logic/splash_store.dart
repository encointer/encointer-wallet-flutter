// ignore_for_file: library_private_types_in_public_api

import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';

import 'package:encointer_wallet/service/log/log_service.dart';

part 'splash_store.g.dart';

class SplashViewStore = _SplashViewStoreBase with _$SplashViewStore;

abstract class _SplashViewStoreBase with Store {
  const _SplashViewStoreBase(this.auth);

  final LocalAuthentication auth;

  Future<bool> authinticate() async {
    try {
      final didAuthenticate = await auth.authenticate(
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
      final isDeviceSupported = await auth.isDeviceSupported();
      return isDeviceSupported;
    } catch (e, s) {
      Log.e('$e', 'SplashViewState', s);
      return false;
    }
  }
}
