import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterConatctNamePubkey(FlutterDriver driver, String name, String pubKey) async {
  await driver.tap(find.byValueKey('contact-address'));
  await driver.enterText(pubKey);
  await driver.tap(find.byValueKey('contact-name'));
  await driver.enterText(name);
}

Future<void> enterChangeContactName(FlutterDriver driver, String newName) async {
  await driver.waitFor(find.byValueKey('contact-name-edit'));
  await driver.tap(find.byValueKey('contact-name-edit'));
  await driver.waitFor(find.byValueKey('contact-name-field'));
  await driver.tap(find.byValueKey('contact-name-field'));
  await driver.enterText(newName);
}
