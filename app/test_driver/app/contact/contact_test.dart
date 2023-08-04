import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'contact_helper.dart';

Future<void> checkContactEmpty(FlutterDriver driver) async {
  await driver.takeLocalScreenshot(Screenshots.contactsOverviewEmpty);
}

Future<void> addContact(FlutterDriver driver, String name, String pubKey) async {
  await driver.tap(find.byValueKey(EWTestKeys.addContact));
  await driver.takeLocalScreenshot(Screenshots.addContact);
  await enterConatctNameAndPubkey(driver, name, pubKey);
  await driver.tap(find.byValueKey(EWTestKeys.contactSave));
  await driver.waitFor(find.byValueKey(name));
}

Future<void> contactDetailView(FlutterDriver driver, String name) async {
  await driver.waitFor(find.byValueKey(name));
  await driver.tap(find.byValueKey(name));
}

Future<void> changeContactName(FlutterDriver driver, String name, String newName) async {
  await contactDetailView(driver, name);
  await driver.waitFor(find.byValueKey(EWTestKeys.contactNameEdit));
  await driver.takeLocalScreenshot(Screenshots.contactView);
  await enterChangeContactName(driver, newName);
  await driver.tap(find.byValueKey(EWTestKeys.contactNameEditCheck));
  await driver.waitFor(find.text(newName));
  await driver.takeLocalScreenshot(Screenshots.changeContactName);
}

Future<void> sendEndorse(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.tapEndorseButton));
  await driver.tap(find.byValueKey(EWTestKeys.tapEndorseButton));
}

Future<void> senMoneyToContact(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.sendMoneyToAccount));
  await driver.tap(find.byValueKey(EWTestKeys.sendMoneyToAccount));
}
