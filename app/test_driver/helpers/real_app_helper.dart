import 'dart:developer';

import 'package:flutter_driver/flutter_driver.dart';

import 'add_delay.dart';
import 'command/real_app_command.dart';
import 'extension/screenshot_driver_extension.dart';
import 'participant_type.dart';
import 'screenshots.dart';

Future<void> turnDevMode(FlutterDriver driver) async {
  await scrollToDevMode(driver);
  await driver.tap(find.byValueKey('dev-mode'));

  await scrollToNextPhaseButton(driver);
}

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

Future<void> refreshWalletPage(FlutterDriver driver) async {
  await driver.scroll(find.byType('RefreshIndicator'), 20, 300, const Duration(seconds: 1));
}

Future<void> closePanel(FlutterDriver driver) async {
  await driver.scroll(find.byValueKey('drag-handle-panel'), 0, 300, const Duration(seconds: 1));
}

Future<void> scrollToCeremonyBox(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('ceremony-box-wallet'),
    dyScroll: -300,
  );
}

Future<void> scrollToPanelController(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('panel-controller'),
    dyScroll: 300,
  );
}

Future<void> tapAndWaitNextPhase(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('next-phase-button'));
  await driver.waitFor(find.byType('SnackBar'));
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
  await scrollToCeremonyBox(driver);
  await driver.waitFor(find.byValueKey('unregister-button'));
  await driver.tap(find.byValueKey('unregister-button'));
  await driver.waitFor(find.byValueKey('unregister-dialog'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.homeUnregisterDialog);
  await driver.tap(find.byValueKey('ok-button'));
  await driver.waitFor(find.byValueKey('registration-meetup-button'));
  await addDelay(1000);
}

Future<void> changeAccountFromPanel(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey(account));
  await closePanel(driver);
  await addDelay(1000);
}

Future<void> importAccount(
  FlutterDriver driver,
  String accountName,
  String seedOrMnemonic, {
  bool shouldTakeScreenshot = false,
}) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey('add-account-panel'));

  await driver.waitFor(find.byValueKey('import-account'));
  await driver.tap(find.byValueKey('import-account'));

  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(accountName);

  await driver.tap(find.byValueKey('account-source'));
  await driver.enterText(seedOrMnemonic);
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.importAccount);
  await driver.tap(find.byValueKey('account-import-next'));
  await driver.waitFor(find.byValueKey('panel-controller'));

  await closePanel(driver);
}

Future<void> importAccountAndRegisterMeetup(FlutterDriver driver, String accountName, String seedOrMnemonic) async {
  await importAccount(driver, accountName, seedOrMnemonic);
  await scrollToCeremonyBox(driver);

  await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
  await scrollToPanelController(driver);
  await addDelay(1000);
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

Future<void> dismissUpgradeDialogOnAndroid(FlutterDriver driver) async {
  final operationSystem = await driver.requestData(RealAppTestCommand.getPlatform);
  // ignore: avoid_print
  print('operationSystem ==================> $operationSystem');

  if (operationSystem == 'android') {
    try {
      log('Waiting for upgrader alert dialog');
      await driver.waitFor(find.byType('AlertDialog'));

      log('Tapping ignore button');
      await driver.tap(find.text('IGNORE'));
    } catch (e) {
      log(e.toString());
    }
  }
}
