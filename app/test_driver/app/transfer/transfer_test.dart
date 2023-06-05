import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'transfer_helper.dart';
import 'transfer_keys.dart';

Future<void> senMoneyToAccount(FlutterDriver driver, String recieveName, String amount) async {
  await driver.takeLocalScreenshot(Screenshots.sendView);
  await enterTransferAmount(driver, amount);
  await driver.tap(find.byValueKey(TransferKeys.transferSelectAccount));
  await driver.waitFor(find.byValueKey(recieveName));
  await driver.tap(find.byValueKey(recieveName));
  await confirmTransaction(driver);
}

Future<void> sendMoneyToSelectedAccount(FlutterDriver driver, String amount) async {
  await driver.waitFor(find.byValueKey(TransferKeys.transferAmountInput));
  await driver.tap(find.byValueKey(TransferKeys.transferAmountInput));
  await driver.enterText(amount);
  await confirmTransaction(driver);
}

Future<void> confirmTransaction(FlutterDriver driver) async {
  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey(TransferKeys.makeTransfer));
    await driver.tap(find.byValueKey(TransferKeys.makeTransfer));
    await driver.waitFor(find.byValueKey(TransferKeys.makeTransferSend));
    await driver.tap(find.byValueKey(TransferKeys.makeTransferSend));
    await driver.waitFor(find.byValueKey(TransferKeys.transferDone));
    await driver.takeLocalScreenshot(Screenshots.txConfirmationView);
    await driver.tap(find.byValueKey(TransferKeys.transferDone));
  });
}
