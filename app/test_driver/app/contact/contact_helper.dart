import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterConatctNameAndPubkey(FlutterDriver driver, String name, String pubKey) async {
  await driver.tap(find.byValueKey(EWTestKeys.contactAddress));
  await driver.enterText(pubKey);
  await driver.tap(find.byValueKey(EWTestKeys.contactName));
  await driver.enterText(name);
}

Future<void> enterChangeContactName(FlutterDriver driver, String newName) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.contactNameEdit));
  await driver.tap(find.byValueKey(EWTestKeys.contactNameEdit));
  await driver.waitFor(find.byValueKey(EWTestKeys.contactNameField));
  await driver.tap(find.byValueKey(EWTestKeys.contactNameField));
  await driver.enterText(newName);
}
