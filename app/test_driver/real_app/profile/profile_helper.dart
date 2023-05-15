import 'package:flutter_driver/flutter_driver.dart';

Future<void> scrollToDevMode(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('profile-list-view'),
    find.byValueKey('dev-mode'),
    dyScroll: -300,
  );
}

Future<void> scrollToNextPhaseButton(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('profile-list-view'),
    find.byValueKey('next-phase-button'),
    dyScroll: -300,
  );
}

Future<void> tapDevMode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('dev-mode'));
}

Future<void> tapNextPhase(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('next-phase-button'));
  await driver.tap(find.byValueKey('next-phase-button'));
  await driver.waitFor(find.byType('SnackBar'));
}
