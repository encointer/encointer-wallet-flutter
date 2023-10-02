import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'transfer_helper.dart';

Future<void> senMoneyToAccount(FlutterDriver driver, String recieveName, String amount) async {
  await driver.takeLocalScreenshot(Screenshots.sendView);
  await enterTransferAmount(driver, amount);
  await driver.tap(find.byValueKey(EWTestKeys.transferSelectAccount));
  await driver.waitFor(find.byValueKey(recieveName));
  await driver.tap(find.byValueKey(recieveName));
  await confirmTransaction(driver);
}

Future<void> sendMoneyToSelectedAccount(FlutterDriver driver, String amount) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.transferAmountInput));
  await driver.tap(find.byValueKey(EWTestKeys.transferAmountInput));
  await driver.enterText(amount);
  await confirmTransaction(driver);
}

Future<void> confirmTransaction(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransfer));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransfer));
    await driver.waitFor(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.tap(find.byValueKey(EWTestKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(EWTestKeys.transferDone));
    await driver.takeLocalScreenshot(Screenshots.txConfirmationView);
    await driver.tap(find.byValueKey(EWTestKeys.transferDone));
  });
}
