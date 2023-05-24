import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver.dart';

Future<void> sendFromQrWithAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('mock-qr-data-row'));
  await driver.tap(find.byValueKey('invoice-with-amount-to-scan'));

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

Future<void> sendFromQrWithoutAmount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('mock-qr-data-row'));
  await driver.tap(find.byValueKey('invoice-with-no-amount-to-scan'));

  await driver.waitFor(find.byValueKey('transfer-listview'));
  await driver.tap(find.byValueKey('transfer-amount-input'));

  await driver.enterText('0.01');
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

Future<void> saveContactFromQrContact(FlutterDriver driver, [bool contactToSaveToAddress = false]) async {
  await driver.waitFor(find.byValueKey('mock-qr-data-row'));

  if (contactToSaveToAddress) {
    await driver.tap(find.byValueKey('contact-to-save-to-address'));
  } else {
    await driver.tap(find.byValueKey('profile-to-scan'));
  }

  await driver.waitFor(find.byValueKey('contact-save'));
  await driver.tap(find.byValueKey('contact-save'));
}

Future<void> saveContactFromQrInvoice(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('mock-qr-data-row'));
  await driver.tap(find.byValueKey('invoice-to-save-to-address'));
  await driver.waitFor(find.byValueKey('contact-save'));
  await driver.tap(find.byValueKey('contact-save'));
}
