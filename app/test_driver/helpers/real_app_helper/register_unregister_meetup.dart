import 'package:flutter_driver/flutter_driver.dart';

import '../add_delay.dart';
import '../extension/screenshot_driver_extension.dart';
import '../participant_type.dart';
import '../screenshots/screenshots.dart';

Future<void> registerAndWait(
  FlutterDriver driver,
  ParticipantTypeTestHelper registrationType, {
  bool shouldTakeScreenshot = false,
}) async {
  await driver.tap(find.byValueKey('registration-meetup-button'));
  await driver.waitFor(find.byValueKey('educate-dialog-${registrationType.type}'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(registrationType.educationDialogScreenshotName);
  await driver.tap(find.byValueKey('close-educate-dialog'));
  await driver.waitFor(find.byValueKey('is-registered-info'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(registrationType.screenshotName);
}

Future<void> unregisterAndWait(FlutterDriver driver, {bool shouldTakeScreenshot = false}) async {
  await driver.waitFor(find.byValueKey('unregister-button'));
  await driver.tap(find.byValueKey('unregister-button'));
  await driver.waitFor(find.byValueKey('unregister-dialog'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.homeUnregisterDialog);
  await driver.tap(find.byValueKey('ok-button'));
  await driver.waitFor(find.byValueKey('registration-meetup-button'));
  await addDelay(1000);
}
