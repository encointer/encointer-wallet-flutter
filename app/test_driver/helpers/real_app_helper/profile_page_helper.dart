import 'package:flutter_driver/flutter_driver.dart';

Future<void> turnDevMode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('dev-mode'));
}

Future<void> tapAndWaitNextPhase(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('next-phase-button'));
  await driver.tap(find.byValueKey('next-phase-button'));
  await driver.waitFor(find.byType('SnackBar'));
}
