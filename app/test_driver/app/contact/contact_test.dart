import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'contact_helper.dart';
import 'contact_keys.dart';

Future<void> checkContactEmpty(FlutterDriver driver) async {
  await driver.takeLocalScreenshot(Screenshots.contactsOverviewEmpty);
}

Future<void> addContact(FlutterDriver driver, String name, String pubKey) async {
  await driver.tap(find.byValueKey('add-contact'));
  await driver.takeLocalScreenshot(Screenshots.addContact);
  await enterConatctNameAndPubkey(driver, name, pubKey);
  await driver.tap(find.byValueKey(ContactKeys.contactSave));
  await driver.waitFor(find.byValueKey(name));
}

Future<void> contactDetailView(FlutterDriver driver, String name) async {
  await driver.waitFor(find.byValueKey(name));
  await driver.tap(find.byValueKey(name));
}

Future<void> changeContactName(FlutterDriver driver, String name, String newName) async {
  await contactDetailView(driver, name);
  await driver.waitFor(find.byValueKey('contact-name-edit'));
  await driver.takeLocalScreenshot(Screenshots.contactView);
  await enterChangeContactName(driver, newName);
  await driver.tap(find.byValueKey('contact-name-edit-check'));
  await driver.waitFor(find.text(newName));
  await driver.takeLocalScreenshot(Screenshots.changeContactName);
}

Future<void> sendEndorse(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('tap-endorse-button'));
  await driver.tap(find.byValueKey('tap-endorse-button'));
}

Future<void> senMoneyToContact(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('send-money-to-account'));
  await driver.tap(find.byValueKey('send-money-to-account'));
}
