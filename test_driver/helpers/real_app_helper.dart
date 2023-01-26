import 'dart:developer';

import 'package:flutter_driver/flutter_driver.dart';

import 'add_delay.dart';

const String getPlatformCommand = 'getPlatform';

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

Future<void> registerAndWait(FlutterDriver driver, String registrationType) async {
  await driver.tap(find.byValueKey('registration-meetup-button'));
  await driver.waitFor(find.byValueKey('educate-dialog-$registrationType'));
  await driver.tap(find.byValueKey('close-educate-dialog'));
  await driver.waitFor(find.byValueKey('is-registered-info'));
  await addDelay(1000);
}

Future<void> changeAccountFromPanel(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey(account));
  await closePanel(driver);
  await addDelay(1000);
}

Future<void> importAccountAndRegisterMeetup(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey('add-account-panel'));

  await driver.waitFor(find.byValueKey('import-account'));
  await driver.tap(find.byValueKey('import-account'));

  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(account);

  await driver.tap(find.byValueKey('account-source'));
  await driver.enterText('//$account');

  await driver.tap(find.byValueKey('account-import-next'));
  await driver.waitFor(find.byValueKey('panel-controller'));

  await scrollToCeremonyBox(driver);

  await registerAndWait(driver, 'Bootstrapper');

  await scrollToPanelController(driver);
  await addDelay(1000);
}

Future<void> startMeetupTest(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('profile-list-view'),
    find.byValueKey('start-meetup'),
    dyScroll: -300,
  );

  await driver.tap(find.byValueKey('start-meetup'));
  await addDelay(500);

  await driver.waitFor(find.byValueKey('attendees-count'));
  await driver.tap(find.byValueKey('attendees-count'));
  await driver.enterText('4');
  await addDelay(500);
  await driver.tap(find.byValueKey('ceremony-step-1-next'));

  await driver.waitFor(find.byValueKey('attest-all-participants-dev'));
  await driver.tap(find.byValueKey('attest-all-participants-dev'));
  await addDelay(500);
  await driver.waitFor(find.byType('SnackBar'));
  await driver.tap(find.byValueKey('close-meetup'));

  await driver.waitFor(find.byValueKey('submit-claims'));
  await driver.tap(find.byValueKey('submit-claims'));
  await addDelay(500);

  await driver.waitFor(find.byValueKey('panel-controller'));
  await scrollToPanelController(driver);
  await addDelay(1000);
}

Future<void> dismissUpgradeDialogOnAndroid(FlutterDriver driver) async {
  final operationSystem = await driver.requestData(getPlatformCommand);
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
