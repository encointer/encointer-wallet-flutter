import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver.dart';
import '../app.dart';

Future<void> getQrVoucherAndFund(FlutterDriver driver) async {
  await scrollToPanelController(driver);
  await goToTransferViewFromHomeView(driver);
  await voucherGetToTransferPageThenToVoucher(driver);

  await driver.runUnsynchronized(() async {
    await fundVoucher(driver);
  });
}

Future<void> scanVoucherFromQrScanPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(VoucherKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(VoucherKeys.voucherToScan));
}

Future<void> voucherGetToTransferPageThenToVoucher(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(VoucherKeys.openQrScannerOnSendPage));
  await scanVoucherFromQrScanPage(driver);
  await driver.waitFor(find.byValueKey(VoucherKeys.voucherToTransferPage));
  await driver.tap(find.byValueKey(VoucherKeys.voucherToTransferPage));
}

Future<void> fundVoucher(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('transfer-listview'));
  await driver.tap(find.byValueKey('transfer-amount-input'));

  await driver.enterText('0.3');
  await driver.takeScreenshot(Screenshots.sendView);

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey('make-transfer'));
    await driver.tap(find.byValueKey('make-transfer'));

    await driver.waitFor(find.byValueKey('make-transfer-send'));
    await driver.tap(find.byValueKey('make-transfer-send'));
    await driver.waitFor(find.byValueKey('transfer-done'));
    await driver.takeScreenshot(Screenshots.txConfirmationView);
    await driver.tap(find.byValueKey('transfer-done'));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  });
}

Future<void> getQrVoucherAndRedeem(FlutterDriver driver) async {
  await navigateToScanPage(driver);
  await scanVoucherFromQrScanPage(driver);
  await driver.waitFor(find.byValueKey(VoucherKeys.submitVoucher));
  await driver.tap(find.byValueKey(VoucherKeys.submitVoucher));
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(VoucherKeys.voucherDialogOk));
    await driver.tap(find.byValueKey(VoucherKeys.voucherDialogOk));
  });
}

class VoucherKeys {
  static const submitVoucher = 'submit-voucher';
  static const mockQrDataRow = 'mock-qr-data-row';
  static const voucherToScan = 'voucher-to-scan';
  static const openQrScannerOnSendPage = 'open-qr-scanner-on-send-page';
  static const voucherToTransferPage = 'voucher-to-transfer-page';
  static const voucherDialogOk = 'voucher-dialog-ok';
}
