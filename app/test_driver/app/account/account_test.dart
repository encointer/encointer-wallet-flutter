import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'account_helper.dart';

Future<void> choosingCid(FlutterDriver driver, int index) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.cidMarkerIcon(index)));
  await driver.tap(find.byValueKey(EWTestKeys.cidMarkerIcon(index)));
  await driver.waitFor(find.byValueKey(EWTestKeys.cidMarkerDescription(index)));
  await driver.takeLocalScreenshot(Screenshots.chooseCommunityMap);
  await driver.tap(find.byValueKey(EWTestKeys.cidMarkerDescription(index)));
}

Future<void> createAccount(FlutterDriver driver, String account) async {
  await driver.takeLocalScreenshot(Screenshots.createAccount);
  await enterAccountName(driver, account);
  await driver.tap(find.byValueKey(EWTestKeys.createAccountNext));
}

Future<void> createPin(FlutterDriver driver, String pin) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountPin));
  await driver.takeLocalScreenshot(Screenshots.pinEntry);
  await enterPin(driver, EWTestKeys.zero001);
  await driver.tap(find.byValueKey(EWTestKeys.createAccountConfirm));
}

Future<void> createNewbieAccount(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountName));
  await driver.tap(find.byValueKey(EWTestKeys.createAccountName));
  await enterAccountName(driver, account);
  await driver.tap(find.byValueKey(EWTestKeys.createAccountConfirm));
}

Future<void> importAccount(FlutterDriver driver, String accountName, String seedOrMnemonic) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.importAccount));
  await driver.tap(find.byValueKey(EWTestKeys.importAccount));
  await driver.takeLocalScreenshot(Screenshots.importAccount);
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountName));
  await enterAccountName(driver, accountName);
  await enterAccountMnemonic(driver, seedOrMnemonic);
  await driver.tap(find.byValueKey(EWTestKeys.accountImportNext));
  await driver.waitFor(find.byValueKey(EWTestKeys.panelController));
}
