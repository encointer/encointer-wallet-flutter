import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterAccountName(FlutterDriver driver, String accountName) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountName));
  await driver.tap(find.byValueKey(EWTestKeys.createAccountName));
  await driver.enterText(accountName);
}

Future<void> enterAccountMnemonic(FlutterDriver driver, String seedOrMnemonic) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.accountSource));
  await driver.tap(find.byValueKey(EWTestKeys.accountSource));
  await driver.enterText(seedOrMnemonic);
}

Future<void> enterPin(FlutterDriver driver, String password) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountPin));
  await driver.tap(find.byValueKey(EWTestKeys.createAccountPin));
  await driver.enterText(password);
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountPin2));
  await driver.tap(find.byValueKey(EWTestKeys.createAccountPin2));
  await driver.enterText(password);
}
