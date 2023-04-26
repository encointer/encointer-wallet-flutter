import 'package:upgrader/upgrader.dart';

/// [AppEnvironment] is needed to set development environemt
/// for now, we have [AppEnvironment.DEV] or [AppEnvironment.PROD] modes
/// For ex: We start working on Announcements,
/// we keep seeing and testing it in `DEV` mode,
/// but it doesn't go onto production unless
/// it's tested and approved.
/// This is usually practiced for working in a team
/// when a team member adds new features and
/// let's tester to test them
enum AppEnvironment { DEV, PROD }

class AppConfig {
  const AppConfig({
    required this.appEnvironment,
    this.mockSubstrateApi = false,
    this.isTestMode = false,
    this.appCast,
  });

  /// [mockSubstrateApi] indicates whether the app uses a mocked api `MockApi` or the real api `Api`.
  final bool mockSubstrateApi;

  /// [isTestMode] indicates whether the app is running in test mode.
  final bool isTestMode;

  /// [appCast] is used to provide fake information about the app version for `Upgrader` package.
  final AppcastConfiguration? appCast;

  /// If [AppcastConfiguration] variable is not null, the app is running real integration test.
  /// If [isIntegrationTest] value is `true`, test will close upgrader alert and won't ask notifications permission.
  bool get isIntegrationTest => appCast != null;

  /// For now, it breaks nothing and has no effect, but we'll be using it a lot in the future
  final AppEnvironment appEnvironment;
}
