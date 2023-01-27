import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/modules/modules.dart';

class AppConfig {
  const AppConfig({
    this.initialRoute = SplashView.route,
    this.mockSubstrateApi = false,
    this.appCast,
  });

  final String initialRoute;
  final bool mockSubstrateApi;
  final AppcastConfiguration? appCast;

  /// If [mockSubstrateApi] is set to `true`, the app uses [LocalStorage] instead of a [MockLocalStorage].
  /// By default, it is set to `false`. It is used for unit test and integration test that uses [MockLocalStorage].
  bool get isTestMode => mockSubstrateApi;

  /// If [AppcastConfiguration] variable is not null, the app is running real integration test.
  /// If [isIntegrationTest] value is `true`, test will close upgrader alert and won't ask notifications permission.
  bool get isIntegrationTest => appCast != null;
}
