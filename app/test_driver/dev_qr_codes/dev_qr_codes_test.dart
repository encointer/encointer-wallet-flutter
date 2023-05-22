import 'package:flutter_driver/flutter_driver.dart';
import '../helpers/extension/screenshot_driver_extension.dart';
import '../helpers/real_app_helper.dart';
import '../helpers/screenshots.dart';
import '../helpers/add_delay.dart';

Future<void> qrTurnOnDevMode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('profile'));
  await driver.takeScreenshot(Screenshots.profileView);
  await turnDevModeToTestQrScan(driver);
  await addDelay(1000);
}

Future<void> qrFromHomeTestAndSaveContact(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('scan'));
  await saveContactFromQrContact(driver);
}

Future<void> qrFromHomeTestAndSendWithAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('scan'));
  await sendFromQrWithAmount(driver);
}

Future<void> qrFromHomeTestAndSendWithoutAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('scan'));
  await sendFromQrWithoutAmount(driver);
}

Future<void> qrFromSendPageTestAndSendWithAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('wallet'));
  await driver.tap(find.byValueKey('transfer'));
  await driver.waitFor(find.byValueKey('transfer-listview'));
  await driver.tap(find.byValueKey('transfer_send'));
  await sendFromQrWithAmount(driver);
}

Future<void> qrFromSendPageTestAndSendWithoutAmount(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('transfer'));
  await driver.waitFor(find.byValueKey('transfer-listview'));
  await driver.tap(find.byValueKey('transfer_send'));
  await sendFromQrWithoutAmount(driver);
}

Future<void> qrFromContactAddContactFromQrContact(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('contacts'));
  await driver.takeScreenshot(Screenshots.contactsOverviewEmpty);
  await driver.tap(find.byValueKey('add-contact'));
  await driver.tap(find.byValueKey('scan-barcode'));
  await saveContactFromQrContact(driver, true);
  await driver.tap(find.byValueKey('back-to-contacts-page'));
  await addDelay(1000);
}

Future<void> qrFromContactAddContactFromQrInvoice(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('contacts'));
  await driver.takeScreenshot(Screenshots.contactsOverviewEmpty);
  await driver.tap(find.byValueKey('add-contact'));
  await driver.tap(find.byValueKey('scan-barcode'));
  await saveContactFromQrInvoice(driver);
  await driver.tap(find.byValueKey('back-to-contacts-page'));
  await addDelay(1000);
}
