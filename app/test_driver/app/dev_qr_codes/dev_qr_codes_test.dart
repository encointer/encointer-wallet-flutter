import 'package:flutter_driver/flutter_driver.dart';

import '../home/home_helper.dart';
import '../navigate.dart';
import '../transfer/transfer_keys.dart';
import 'dev_qr_code_keys.dart';
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
  await driver.tap(find.byValueKey('transfer'));
  await driver.waitFor(find.byValueKey(TransferKeys.transferListview));
  await driver.tap(find.byValueKey(DevQrCodeKeys.openQrScannerOnSendPage));
  await sendFromQrWithAmount(driver);
}

Future<void> qrFromSendPageTestAndSendWithoutAmount(FlutterDriver driver) async {
  await scrollToPanelController(driver);
  await driver.tap(find.byValueKey('transfer'));
  await driver.waitFor(find.byValueKey(TransferKeys.transferListview));
  await driver.tap(find.byValueKey(DevQrCodeKeys.openQrScannerOnSendPage));
  await sendFromQrWithoutAmount(driver);
}

Future<void> qrFromContactAddContactFromQrContact(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('add-contact'));
  await driver.tap(find.byValueKey('scan-barcode'));
  await saveContactFromQrContact(driver, true);
  await Future<void>.delayed(const Duration(milliseconds: 500));
}
