import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterAccountName(FlutterDriver driver, String accountName) async {
  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(accountName);
}

Future<void> enterAccountMnemonic(FlutterDriver driver, String seedOrMnemonic) async {
  await driver.waitFor(find.byValueKey('account-source'));
  await driver.tap(find.byValueKey('account-source'));
  await driver.enterText(seedOrMnemonic);
}

Future<void> enterPin(FlutterDriver driver, String password) async {
  await driver.waitFor(find.byValueKey('create-account-pin'));
  await driver.tap(find.byValueKey('create-account-pin'));
  await driver.enterText(password);
  await driver.waitFor(find.byValueKey('create-account-pin2'));
  await driver.tap(find.byValueKey('create-account-pin2'));
  await driver.enterText(password);
}
