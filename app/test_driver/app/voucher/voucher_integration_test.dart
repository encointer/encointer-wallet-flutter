import 'package:ew_test_keys/ew_test_keys.dart';
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
  await driver.waitFor(find.byValueKey(EWTestKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(EWTestKeys.voucherToScan));
}

Future<void> voucherGetToTransferPageThenToVoucher(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.openQrScannerOnSendPage));
  await scanVoucherFromQrScanPage(driver);
  await driver.waitFor(find.byValueKey(EWTestKeys.voucherToTransferPage));
  await driver.tap(find.byValueKey(EWTestKeys.voucherToTransferPage));
}

Future<void> fundVoucher(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.transferListview));
  await driver.tap(find.byValueKey(EWTestKeys.transferAmountInput));

  await driver.enterText('0.3');
  await driver.takeScreenshot(Screenshots.sendView);

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransfer));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransfer));

    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(EWTestKeys.transferDone));
    await driver.takeScreenshot(Screenshots.txConfirmationView);
    await driver.tap(find.byValueKey(EWTestKeys.transferDone));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  });
}

Future<void> getQrVoucherAndRedeem(FlutterDriver driver) async {
  await navigateToScanPage(driver);
  await scanVoucherFromQrScanPage(driver);
  await driver.waitFor(find.byValueKey(EWTestKeys.submitVoucher));
  await driver.tap(find.byValueKey(EWTestKeys.submitVoucher));
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(EWTestKeys.voucherDialogOk));
    await driver.tap(find.byValueKey(EWTestKeys.voucherDialogOk));
  });
}
