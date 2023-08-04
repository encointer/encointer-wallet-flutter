import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterNewAccountName(FlutterDriver driver, String newName) async {
  await driver.tap(find.byValueKey(EWTestKeys.accountNameField));
  await driver.enterText(newName);
}

Future<void> enterPin(FlutterDriver driver, String pin) async {
  await driver.tap(find.byValueKey(EWTestKeys.inputPasswordDialog));
  await driver.enterText(pin);
}
