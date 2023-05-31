import 'package:upgrader/upgrader.dart';

class AppConfig {
  const AppConfig({this.isIntegrationTest = false, this.appCast});

  /// [appCast] is used to provide fake information about the app version for the `Upgrader` package.
  final AppcastConfiguration? appCast;

  /// If the [isIntegrationTest] value is `true`, the following conditions will occur:
  /// 1) The test will close the Upgrader alert.
  /// 2) The app won't ask for notification permissions.
  /// 3) The app will show the full `acoountPubKey` in the `AccountManage` page.
  /// 4) The `_animationController!.reset()` method will not be called for the `PaymentConfirmationPage`.
  final bool isIntegrationTest;
}
