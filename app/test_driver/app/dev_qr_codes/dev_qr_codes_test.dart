import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver.dart';
import '../navigate.dart';
import '../profile/profile_helper.dart';
import 'dev_qr_codes_test_helpers.dart';

Future<void> qrTurnOnDevMode(FlutterDriver driver) async {
  await navigateToProfilePage(driver);
  await driver.takeScreenshot(Screenshots.profileView);
  await tapDevMode(driver);
  await Future<void>.delayed(const Duration(milliseconds: 1000));
}

Future<void> qrFromHomeTestAndSaveContact(FlutterDriver driver) async {
  await navigateToScanPage(driver);
  await saveContactFromQrContact(driver);
}

Future<void> qrFromHomeTestAndSendWithAmount(FlutterDriver driver) async {
  await navigateToScanPage(driver);
  await sendFromQrWithAmount(driver);
}

Future<void> qrFromHomeTestAndSendWithoutAmount(FlutterDriver driver) async {
  await navigateToScanPage(driver);
  await sendFromQrWithoutAmount(driver);
}

Future<void> qrFromSendPageTestAndSendWithAmount(FlutterDriver driver) async {
  await navigateToHomePage(driver);
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
  await navigateToContactsPage(driver);
  await driver.tap(find.byValueKey('add-contact'));
  await driver.tap(find.byValueKey('scan-barcode'));
  await saveContactFromQrContact(driver, true);
  await Future<void>.delayed(const Duration(milliseconds: 500));
}

Future<void> qrFromContactAddContactFromQrInvoice(FlutterDriver driver) async {
  await navigateToHomePage(driver);
  await navigateToContactsPage(driver);
  await driver.tap(find.byValueKey('add-contact'));
  await driver.tap(find.byValueKey('scan-barcode'));
  await saveContactFromQrInvoice(driver);
  await Future<void>.delayed(const Duration(milliseconds: 1000));
}
