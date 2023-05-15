import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver_extension.dart';
import '../../helpers/screenshots/screenshots.dart';
import 'transfer_helper.dart';

Future<void> senMoneyToAccount(FlutterDriver driver, String recieveName, String amount) async {
  await driver.takeScreenshot(Screenshots.sendView);
  await enterTransferAmount(driver, amount);
  await driver.tap(find.byValueKey('transfer-select-account'));
  await driver.waitFor(find.byValueKey(recieveName));
  await driver.tap(find.byValueKey(recieveName));
  await confirmTransaction(driver);
}

Future<void> sendMoneyToSelectedAccount(FlutterDriver driver, String amount) async {
  await driver.waitFor(find.byValueKey('transfer-amount-input'));
  await driver.tap(find.byValueKey('transfer-amount-input'));
  await driver.enterText(amount);
  await confirmTransaction(driver);
}

Future<void> confirmTransaction(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey('make-transfer'));
    await driver.tap(find.byValueKey('make-transfer'));

    await driver.waitFor(find.byValueKey('make-transfer-send'));
    await driver.tap(find.byValueKey('make-transfer-send'));
    await driver.waitFor(find.byValueKey('transfer-done'));
    await driver.tap(find.byValueKey('transfer-done'));
  });
}
