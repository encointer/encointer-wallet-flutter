import 'package:flutter_driver/flutter_driver.dart';

import '../extension/screenshot_driver_extension.dart';
import '../screenshots/screenshots.dart';
import 'enter_text.dart';
import 'home_page_helper.dart';

Future<void> createAccount(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('create-account'));
  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.takeScreenshot(Screenshots.createAccount);
  await enterAccountName(driver, account); // TODO(Eldiiar) screenshot with enter text

  await driver.tap(find.byValueKey('create-account-next'));
}

Future<void> createPin(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('create-account-pin'));

  await driver.takeScreenshot(Screenshots.pinEntry);
  await enterCreatePin(driver, '0001'); // TODO(Eldiiar) screenshot with enter text

  await driver.tap(find.byValueKey('create-account-confirm'));
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

  if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.importAccount);
  await driver.waitFor(find.byValueKey('create-account-name'));
  await enterAccountName(driver, accountName);
  await enterAccountMnemonic(driver, seedOrMnemonic);
  // if (shouldTakeScreenshot) await driver.takeScreenshot(Screenshots.importAccount);
  await driver.tap(find.byValueKey('account-import-next'));
  await driver.waitFor(find.byValueKey('panel-controller'));

  await closePanel(driver);
}
