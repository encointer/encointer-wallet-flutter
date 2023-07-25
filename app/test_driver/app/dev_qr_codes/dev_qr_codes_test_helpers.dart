import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> sendFromQrWithAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(EWTestKeys.invoiceWithAmountToScan));

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransfer));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransfer));

    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(EWTestKeys.transferDone));
    await driver.tap(find.byValueKey(EWTestKeys.transferDone));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  });
}

Future<void> sendFromQrWithoutAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(EWTestKeys.invoiceWithNoAmountToScan));

  await driver.waitFor(find.byValueKey(EWTestKeys.transferListview));
  await driver.tap(find.byValueKey(EWTestKeys.transferAmountInput));

  await driver.enterText('0.01');

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransfer));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransfer));
    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(EWTestKeys.transferDone));
    await driver.tap(find.byValueKey(EWTestKeys.transferDone));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  });
}

Future<void> saveContactFromQrContact(FlutterDriver driver, [bool contactToSaveToAddress = false]) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.mockQrDataRow));

  if (contactToSaveToAddress) {
    await driver.tap(find.byValueKey(EWTestKeys.contactToSaveToAddress));
  } else {
    await driver.tap(find.byValueKey(EWTestKeys.profileToScan));
  }

  await driver.waitFor(find.byValueKey(EWTestKeys.contactSave));
  await driver.tap(find.byValueKey(EWTestKeys.contactSave));
}

Future<void> saveContactFromQrInvoice(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(EWTestKeys.invoiceToSaveToAddress));
  await driver.waitFor(find.byValueKey(EWTestKeys.contactSave));
  await driver.tap(find.byValueKey(EWTestKeys.contactSave));
}
