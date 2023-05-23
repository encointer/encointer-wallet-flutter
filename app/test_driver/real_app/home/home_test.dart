import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'home_helper.dart';

Future<void> homeInit(FlutterDriver driver) async {
  await refreshWalletPage(driver);
  await dismissUpgradeDialogOnAndroid(driver);
  await driver.takeLocalScreenshot(Screenshots.homeWithRegisterButton);
}

Future<void> changeCommunity(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.tap(find.byValueKey('panel-controller'));
    await driver.tap(find.byValueKey('add-community'));

    await driver.tap(find.byValueKey('cid-0-marker-icon'));
    await driver.tap(find.byValueKey('cid-0-marker-description'));
    await driver.waitFor(find.byValueKey('add-community'));

    await Future<void>.delayed(const Duration(milliseconds: 1000));
    await closePanel(driver);
    await refreshWalletPage(driver);
  });
}

Future<void> registerAndWait(FlutterDriver driver, ParticipantTypeTestHelper registrationType) async {
  await driver.tap(find.byValueKey('registration-meetup-button'));
  await driver.waitFor(find.byValueKey('educate-dialog-${registrationType.type}'));
  await driver.takeLocalScreenshot(registrationType.educationDialogScreenshotName);
  await driver.tap(find.byValueKey('close-educate-dialog'));
  await driver.waitFor(find.byValueKey('is-registered-info'));
  await driver.takeLocalScreenshot(registrationType.screenshotName);
}

Future<void> unregisterAndWait(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('unregister-button'));
  await driver.tap(find.byValueKey('unregister-button'));
  await driver.waitFor(find.byValueKey('unregister-dialog'));
  await driver.takeLocalScreenshot(Screenshots.homeUnregisterDialog);
  await driver.tap(find.byValueKey('ok-button'));
  await driver.waitFor(find.byValueKey('registration-meetup-button'));
}

Future<void> checkAssignPhaseAssigned(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('list-view-wallet'));
  await scrollToCeremonyBox(driver);
  await driver.waitFor(find.byValueKey('account-assigned'));
  await driver.takeLocalScreenshot(Screenshots.homeAssigningPhaseAssigned);
}

Future<void> checkAssignPhaseUnassigned(FlutterDriver driver) async {
  await scrollToCeremonyBox(driver);
  await driver.waitFor(find.byValueKey('account-unassigned'));
  await driver.takeLocalScreenshot(Screenshots.homeAssigningPhaseUnassigned);
}

Future<void> claimPendingDev(FlutterDriver driver) async {
  await driver.requestData(RealAppTestCommand.devModeOn);
  await driver.waitFor(find.byValueKey('claim-pending-dev'));
  await driver.tap(find.byValueKey('claim-pending-dev'));
}
