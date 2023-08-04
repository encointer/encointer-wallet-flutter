import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey(EWTestKeys.transferListview),
    find.byValueKey(EWTestKeys.sendToAddress),
    dyScroll: -150,
  );
}

Future<void> enterTransferAmount(FlutterDriver driver, String amount) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.transferAmountInput));
  await driver.tap(find.byValueKey(EWTestKeys.transferAmountInput));
  await driver.enterText(amount);
}
