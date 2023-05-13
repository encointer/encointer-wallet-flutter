import 'package:flutter_driver/flutter_driver.dart';

import '../command/real_app_command.dart';
import '../extension/screenshot_driver_extension.dart';
import '../participant_type.dart';
import '../screenshots/screenshots.dart';
import 'enter_text.dart';
import 'scrolss.dart';

Future<void> refreshWalletPage(FlutterDriver driver) async {
  await driver.scroll(find.byType('RefreshIndicator'), 20, 300, const Duration(seconds: 1));
}

Future<void> closePanel(FlutterDriver driver) async {
  await driver.scroll(find.byValueKey('drag-handle-panel'), 0, 300, const Duration(seconds: 1));
}

Future<void> changeAccountFromPanel(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));
  await closePanel(driver);
}

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
}

Future<void> startMeetupTest(
  FlutterDriver driver, {
  bool shouldTakeScreenshot = false,
  int participantsCount = 3,
}) async {
  await scrollToStartMeetup(driver);
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.homeAttestingPhaseStartMeetup);
  await driver.tap(find.byValueKey('start-meetup'));
  await enterAttendeesCount(driver, participantsCount);
  await driver.tap(find.byValueKey('ceremony-step-1-next'));
  await driver.requestData(RealAppTestCommand.devModeOn);
  await driver.waitFor(find.byValueKey('attest-all-participants-dev'));
  await driver.tap(find.byValueKey('attest-all-participants-dev'));
  await driver.waitFor(find.byType('SnackBar'));
  await driver.tap(find.byValueKey('close-meetup'));
  await driver.waitFor(find.byValueKey('submit-claims'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.step3FinishGathering);
  await driver.tap(find.byValueKey('submit-claims'));

  await driver.waitFor(find.byValueKey('panel-controller'));
  await scrollToPanelController(driver);
}
