import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:local_auth/local_auth.dart';
import 'package:encointer_wallet/service/service.dart';

@immutable
final class LocalAuthService {
  const LocalAuthService(this.localAuthentication);

  final LocalAuthentication localAuthentication;

  static const isDeviceSupportKey = 'is-device-support-key';

  /// Check if local authentication is supported on the device.
  /// Returns a `future` with `true` if supported, `false` otherwise.
  /// Returns `false` and logs errors if a `PlatformException` occurs.
  Future<bool> isDeviceSupported() async {
    try {
      return localAuthentication.isDeviceSupported();
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
      return localAuthentication.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(useErrorDialogs: false),
      );
    } catch (e, s) {
      Log.e('$e', 'LoginStore', s);
      return Future.value(false);
    }
  }
}
