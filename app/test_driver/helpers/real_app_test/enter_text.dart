import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterAccountName(FlutterDriver driver, String accountName) async {
  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(accountName).whenComplete(() => print(accountName));
}

Future<void> enterCreatePin(FlutterDriver driver, String password) async {
  await driver.waitFor(find.byValueKey('create-account-pin'));
  await driver.tap(find.byValueKey('create-account-pin'));
  await driver.enterText(password);
  await driver.waitFor(find.byValueKey('create-account-pin2'));
  await driver.tap(find.byValueKey('create-account-pin2'));
  await driver.enterText(password);
}
