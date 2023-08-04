import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> scrollToDevMode(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey(EWTestKeys.profileListView),
    find.byValueKey(EWTestKeys.devMode),
    dyScroll: -150,
  );
}

Future<void> scrollToNextPhaseButton(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey(EWTestKeys.profileListView),
    find.byValueKey(EWTestKeys.nextPhaseButton),
    dyScroll: -100,
  );
}

Future<void> tapDevMode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.devMode));
}

Future<void> tapNextPhase(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.nextPhaseButton));
  await driver.tap(find.byValueKey(EWTestKeys.nextPhaseButton));
  await driver.waitFor(find.byType('SnackBar'));
}
