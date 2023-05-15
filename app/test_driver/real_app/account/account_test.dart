import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver.dart';
import 'account_helper.dart';

Future<void> choosingCid(FlutterDriver driver, int index) async {
  await driver.waitFor(find.byValueKey('cid-$index-marker-icon'));
  await driver.tap(find.byValueKey('cid-$index-marker-icon'));
  await driver.waitFor(find.byValueKey('cid-$index-marker-description'));
  await driver.takeScreenshot(Screenshots.chooseCommunityMap);
  await driver.tap(find.byValueKey('cid-$index-marker-description'));
}

Future<void> createAccount(FlutterDriver driver, String account) async {
  await driver.takeScreenshot(Screenshots.createAccount);
  await enterAccountName(driver, account);
  await driver.tap(find.byValueKey('create-account-next'));
}

Future<void> createPin(FlutterDriver driver, String pin) async {
  await driver.waitFor(find.byValueKey('create-account-pin'));
  await driver.takeScreenshot(Screenshots.pinEntry);
  await enterPin(driver, '0001');
  await driver.tap(find.byValueKey('create-account-confirm'));
}

Future<void> createNewbieAccount(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.tap(find.byValueKey('create-account-name'));
  await enterAccountName(driver, account);
  await driver.tap(find.byValueKey('create-account-confirm'));
}

Future<void> importAccount(
  FlutterDriver driver,
  String accountName,
  String seedOrMnemonic, {
  bool shouldTakeScreenshot = false,
}) async {
  await driver.waitFor(find.byValueKey('import-account'));
  await driver.tap(find.byValueKey('import-account'));
  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.importAccount);
  await driver.waitFor(find.byValueKey('create-account-name'));
  await enterAccountName(driver, accountName);
  await enterAccountMnemonic(driver, seedOrMnemonic);
  await driver.tap(find.byValueKey('account-import-next'));
  await driver.waitFor(find.byValueKey('panel-controller'));
}
