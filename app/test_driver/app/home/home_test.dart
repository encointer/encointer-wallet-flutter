import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'home_helper.dart';

Future<void> homeInit(FlutterDriver driver) async {
  await refreshWalletPage(driver);
  await driver.takeLocalScreenshot(Screenshots.homeWithRegisterButton);
}

Future<void> changeCommunity(FlutterDriver driver) async {
    await driver.tap(find.byValueKey(EWTestKeys.panelController));
    await driver.tap(find.byValueKey(EWTestKeys.addCommunity));

    await driver.tap(find.byValueKey(EWTestKeys.cidMarkerIcon(0)));
    await driver.tap(find.byValueKey(EWTestKeys.cidMarkerDescription(0)));
    await driver.waitFor(find.byValueKey(EWTestKeys.addCommunity));

    await Future<void>.delayed(const Duration(milliseconds: 1000));
    await closePanel(driver);
    await refreshWalletPage(driver);
}

Future<void> registerAndWait(FlutterDriver driver, ParticipantTypeTestHelper registrationType) async {
  await driver.tap(find.byValueKey(EWTestKeys.registrationMeetupButton));
  await driver.waitFor(find.byValueKey(EWTestKeys.educateDialogRegistrationType(registrationType.type)));
  await driver.takeLocalScreenshot(registrationType.educationDialogScreenshotName);
  await driver.tap(find.byValueKey(EWTestKeys.closeEducateDialog));
  await driver.waitFor(find.byValueKey(EWTestKeys.isRegisteredInfo));
  await driver.takeLocalScreenshot(registrationType.screenshotName);
}

Future<void> unregisterAndWait(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.unregisterButton));
  await driver.tap(find.byValueKey(EWTestKeys.unregisterButton));
  await driver.waitFor(find.byValueKey(EWTestKeys.unregisterDialog));
  await driver.takeLocalScreenshot(Screenshots.homeUnregisterDialog);
  await driver.tap(find.byValueKey(EWTestKeys.okButton));
  await driver.waitFor(find.byValueKey(EWTestKeys.registrationMeetupButton));
}

Future<void> checkAssignPhaseAssigned(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.listViewWallet));
  await scrollToCeremonyBox(driver);
  await driver.waitFor(find.byValueKey(EWTestKeys.accountAssigned));
  await driver.takeLocalScreenshot(Screenshots.homeAssigningPhaseAssigned);
}

Future<void> checkAssignPhaseUnassigned(FlutterDriver driver) async {
  await scrollToCeremonyBox(driver);
  await driver.waitFor(find.byValueKey(EWTestKeys.accountUnassigned));
  await driver.takeLocalScreenshot(Screenshots.homeAssigningPhaseUnassigned);
}

Future<void> claimPendingDev(FlutterDriver driver) async {
  await driver.requestData(TestCommand.devModeOn);
  await driver.waitFor(find.byValueKey(EWTestKeys.claimPendingDev));
  await driver.tap(find.byValueKey(EWTestKeys.claimPendingDev));
}
