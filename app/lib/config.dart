import 'package:upgrader/upgrader.dart';

class AppConfig {
  const AppConfig({
    // this.mockSubstrateApi = false,
    // this.isTestMode = false,
    this.appCast,
  });

  // /// [mockSubstrateApi] indicates whether the app uses a mocked api `MockApi` or the real api `Api`.
  // final bool mockSubstrateApi;

  /// [isTestMode] indicates whether the app is running in test mode.
  // final bool isTestMode;

  /// [appCast] is used to provide fake information about the app version for `Upgrader` package.
  final AppcastConfiguration? appCast;

  /// If [AppcastConfiguration] variable is not null, the app is running real integration test.
  /// If [isIntegrationTest] value is `true`, test will close upgrader alert and won't ask notifications permission.
  bool get isIntegrationTest => appCast != null;
}
