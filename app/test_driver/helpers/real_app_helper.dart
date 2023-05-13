import 'package:flutter_driver/flutter_driver.dart';

import 'add_delay.dart';
import 'extension/screenshot_driver_extension.dart';
import 'real_app_helper/real_app_helper.dart';
import 'screenshots/screenshots.dart';

Future<void> tapAndWaitNextPhase(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('next-phase-button'));
  await driver.waitFor(find.byType('SnackBar'));
}

Future<void> startMeetupTest(
  FlutterDriver driver, {
  bool shouldTakeScreenshot = false,
  int participantsCount = 3,
}) async {
  await driver.scrollUntilVisible(
    find.byValueKey('profile-list-view'),
    find.byValueKey('start-meetup'),
    dyScroll: -300,
  );
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.homeAttestingPhaseStartMeetup);
  await driver.tap(find.byValueKey('start-meetup'));
  await addDelay(500);

  await driver.waitFor(find.byValueKey('attendees-count'));
  await driver.tap(find.byValueKey('attendees-count'));
  await driver.enterText('$participantsCount');
  await driver.tap(find.byValueKey('ceremony-step-1-next'));

  await driver.waitFor(find.byValueKey('attest-all-participants-dev'));
  await driver.tap(find.byValueKey('attest-all-participants-dev'));
  await driver.waitFor(find.byType('SnackBar'));
  await driver.tap(find.byValueKey('close-meetup'));

  await driver.waitFor(find.byValueKey('submit-claims'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.step3FinishGathering);
  await driver.tap(find.byValueKey('submit-claims'));

  await driver.waitFor(find.byValueKey('panel-controller'));
  await scrollToPanelController(driver);
  await addDelay(1000);
}
