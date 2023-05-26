import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterNewAccountName(FlutterDriver driver, String newName) async {
  await driver.tap(find.byValueKey('account-name-field'));
  await driver.enterText(newName);
}

Future<void> enterPin(FlutterDriver driver, String pin) async {
  await driver.tap(find.byValueKey('input-password-dialog'));
  await driver.enterText(pin);
}
