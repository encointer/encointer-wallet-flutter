import 'dart:developer';

import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

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

Future<void> dismissUpgradeDialogOnAndroid(FlutterDriver driver) async {
  final operationSystem = await driver.requestData(TestCommand.getPlatform);
  log('operationSystem ==================> $operationSystem');
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

Future<void> scrollToCeremonyBox(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('ceremony-box-wallet'),
    dyScroll: -150,
  );
}

Future<void> scrollToRegisterButton(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('registration-meetup-button'),
    dyScroll: -150,
  );
}

Future<void> scrollToUnregisterButton(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('unregister-button'),
    dyScroll: -150,
  );
}

Future<void> scrollToPanelController(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('panel-controller'),
    dyScroll: 400,
  );
}

Future<void> scrollToStartMeetup(FlutterDriver driver) async {
  await driver.requestData(TestCommand.devModeOff);
  await driver.scrollUntilVisible(
    find.byValueKey('list-view-wallet'),
    find.byValueKey('start-meetup'),
    dyScroll: -150,
  );
}
