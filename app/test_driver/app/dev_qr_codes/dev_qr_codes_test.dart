import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../home/home_helper.dart';
import '../navigate.dart';
import 'dev_qr_codes_test_helpers.dart';

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
  await scrollToPanelController(driver);
  await driver.tap(find.byValueKey(EWTestKeys.transfer));
  await driver.waitFor(find.byValueKey(EWTestKeys.transferListview));
  await driver.tap(find.byValueKey(EWTestKeys.openQrScannerOnSendPage));
  await sendFromQrWithAmount(driver);
}

Future<void> qrFromSendPageTestAndSendWithoutAmount(FlutterDriver driver) async {
  await scrollToPanelController(driver);
  await driver.tap(find.byValueKey(EWTestKeys.transfer));
  await driver.waitFor(find.byValueKey(EWTestKeys.transferListview));
  await driver.tap(find.byValueKey(EWTestKeys.openQrScannerOnSendPage));
  await sendFromQrWithoutAmount(driver);
}

Future<void> qrFromContactAddContactFromQrContact(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.addContact));
  await driver.tap(find.byValueKey(EWTestKeys.scanBarcode));
  await saveContactFromQrContact(driver, true);
  await Future<void>.delayed(const Duration(milliseconds: 500));
}
