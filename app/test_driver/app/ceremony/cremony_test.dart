import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'ceremony_helper.dart';

Future<void> startMeetupTest(FlutterDriver driver, {int participantsCount = 3}) async {
  await driver.takeLocalScreenshot(Screenshots.homeAttestingPhaseStartMeetup);
  await driver.tap(find.byValueKey(EWTestKeys.startMeetup));
  await driver.takeLocalScreenshot(Screenshots.step1ConfirmNumberOfAttendees);
  await enterAttendeesCount(driver, participantsCount);
  await driver.tap(find.byValueKey(EWTestKeys.ceremonyStep1Next));
  await driver.takeLocalScreenshot(Screenshots.step2QrCode);
  await driver.requestData(TestCommand.devModeOn);
  await driver.waitFor(find.byValueKey(EWTestKeys.attestAllParticipantsDev));
  await driver.tap(find.byValueKey(EWTestKeys.attestAllParticipantsDev));
  await driver.waitFor(find.byType('SnackBar'));
  await driver.tap(find.byValueKey(EWTestKeys.closeMeetup));
  await driver.waitFor(find.byValueKey(EWTestKeys.submitClaims));
  await driver.takeLocalScreenshot(Screenshots.step3FinishGathering);
  await driver.tap(find.byValueKey(EWTestKeys.submitClaims));
  await driver.waitFor(find.byValueKey(EWTestKeys.startMeetup));
}
