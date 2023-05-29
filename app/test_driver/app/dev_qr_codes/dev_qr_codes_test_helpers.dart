import 'package:flutter_driver/flutter_driver.dart';

import '../contact/contact_keys.dart';
import '../transfer/transfer_keys.dart';
import 'dev_qr_code_keys.dart';

Future<void> sendFromQrWithAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(DevQrCodeKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(DevQrCodeKeys.invoiceWithAmountToScan));

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(TransferKeys.makeTransfer));
    await driver.tap(find.byValueKey(TransferKeys.makeTransfer));

    await driver.waitFor(find.byValueKey(TransferKeys.makeTransferSend));
    await driver.tap(find.byValueKey(TransferKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(TransferKeys.transferDone));
    await driver.tap(find.byValueKey(TransferKeys.transferDone));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  });
}

Future<void> sendFromQrWithoutAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(DevQrCodeKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(DevQrCodeKeys.invoiceWithNoAmountToScan));

  await driver.waitFor(find.byValueKey(TransferKeys.transferListview));
  await driver.tap(find.byValueKey(TransferKeys.transferAmountInput));

  await driver.enterText('0.01');

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(TransferKeys.makeTransfer));
    await driver.tap(find.byValueKey(TransferKeys.makeTransfer));
    await driver.waitFor(find.byValueKey(TransferKeys.makeTransferSend));
    await driver.tap(find.byValueKey(TransferKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(TransferKeys.transferDone));
    await driver.tap(find.byValueKey(TransferKeys.transferDone));
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  });
}

Future<void> saveContactFromQrContact(FlutterDriver driver, [bool contactToSaveToAddress = false]) async {
  await driver.waitFor(find.byValueKey(DevQrCodeKeys.mockQrDataRow));

  if (contactToSaveToAddress) {
    await driver.tap(find.byValueKey(DevQrCodeKeys.contactToSaveToAddress));
  } else {
    await driver.tap(find.byValueKey(DevQrCodeKeys.profileToScan));
  }

  await driver.waitFor(find.byValueKey(ContactKeys.contactSave));
  await driver.tap(find.byValueKey(ContactKeys.contactSave));
}

Future<void> saveContactFromQrInvoice(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(DevQrCodeKeys.mockQrDataRow));
  await driver.tap(find.byValueKey(DevQrCodeKeys.invoiceToSaveToAddress));
  await driver.waitFor(find.byValueKey(ContactKeys.contactSave));
  await driver.tap(find.byValueKey(ContactKeys.contactSave));
}
