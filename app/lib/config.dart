import 'package:upgrader/upgrader.dart';

class AppConfig {
  const AppConfig({this.isIntegrationTest = false, this.appCast});

  /// [appCast] is used to provide fake information about the app version for `Upgrader` package.
  final AppcastConfiguration? appCast;

  /// If [isIntegrationTest] value is `true`, test will close upgrader alert and won't ask notifications permission.
  final bool isIntegrationTest;
}
