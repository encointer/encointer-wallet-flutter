import 'package:flutter_driver/flutter_driver.dart';

import 'transfer_keys.dart';

Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey(TransferKeys.transferListview),
    find.byValueKey('send-to-address'),
  );
}

Future<void> enterTransferAmount(FlutterDriver driver, String amount) async {
  await driver.waitFor(find.byValueKey(TransferKeys.transferAmountInput));
  await driver.tap(find.byValueKey(TransferKeys.transferAmountInput));
  await driver.enterText(amount);
}
