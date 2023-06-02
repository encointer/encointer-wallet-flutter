import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver.dart';
import '../app.dart';

Future<void> getQrVoucherAndFund(FlutterDriver driver) async {
  await navigateToHomePage(driver);
  await scrollToPanelController(driver);
  await goToTransferViewFromHomeView(driver);
  await voucherGetToTransferPageThenToVoucher(driver);

  await driver.runUnsynchronized(() async {
    await fundVoucher(driver);
  });
}

Future<void> scanVoucherFromQrScanPage(FlutterDriver driver) async {
  await driver.waitFor(VoucherKeysToFind.mockQrDataRow);
  await driver.tap(VoucherKeysToFind.voucherToScan);
}

Future<void> voucherGetToTransferPageThenToVoucher(FlutterDriver driver) async {
  await driver.tap(VoucherKeysToFind.openQrScannerOnSendPage);
  await scanVoucherFromQrScanPage(driver);
  await driver.waitFor(VoucherKeysToFind.voucherToTransferPage);
  await driver.tap(VoucherKeysToFind.voucherToTransferPage);
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
  await driver.waitFor(VoucherKeysToFind.submitVoucher);
  await driver.tap(VoucherKeysToFind.submitVoucher);
  await driver.runUnsynchronized(() async {
    await driver.waitFor(VoucherKeysToFind.voucherDialogOk);
    await driver.takeLocalScreenshot(Screenshots.voucherDialog);
    await driver.tap(VoucherKeysToFind.voucherDialogOk);
  });
}

class VoucherKeysToFind {
  static final submitVoucher = find.byValueKey('submit_voucher');
  static final mockQrDataRow = find.byValueKey('mock-qr-data-row');
  static final voucherToScan = find.byValueKey('voucher-to-scan');
  static final openQrScannerOnSendPage = find.byValueKey('open-qr-scanner-on-send-page');
  static final voucherToTransferPage = find.byValueKey('voucher_to_transfer_page');
  static final voucherDialogOk = find.byValueKey('voucher_dialog_ok');
}
