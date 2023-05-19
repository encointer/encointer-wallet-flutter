import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/command/real_app_command.dart';
import '../../helpers/extension/screenshot_driver.dart';
import 'ceremony_helper.dart';

Future<void> startMeetupTest(FlutterDriver driver, {int participantsCount = 3}) async {
  await driver.takeScreenshot(Screenshots.homeAttestingPhaseStartMeetup);
  await driver.tap(find.byValueKey('start-meetup'));
  await driver.takeScreenshot(Screenshots.step1ConfirmNumberOfAttendees);
  await enterAttendeesCount(driver, participantsCount);
  await driver.tap(find.byValueKey('ceremony-step-1-next'));
  await driver.takeScreenshot(Screenshots.step2QrCode);
  await driver.requestData(RealAppTestCommand.devModeOn);
  await driver.waitFor(find.byValueKey('attest-all-participants-dev'));
  await driver.tap(find.byValueKey('attest-all-participants-dev'));
  await driver.waitFor(find.byType('SnackBar'));
  await driver.tap(find.byValueKey('close-meetup'));
  await driver.waitFor(find.byValueKey('submit-claims'));
  await driver.takeScreenshot(Screenshots.step3FinishGathering);
  await driver.tap(find.byValueKey('submit-claims'));
  await driver.waitFor(find.byValueKey('start-meetup'));
}
