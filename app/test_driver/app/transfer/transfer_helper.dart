import 'package:flutter_driver/flutter_driver.dart';

Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('transfer-listview'),
    find.byValueKey('send-to-address'),
    dyScroll: -200,
  );
}

Future<void> enterTransferAmount(FlutterDriver driver, String amount) async {
  await driver.waitFor(find.byValueKey('transfer-amount-input'));
  await driver.tap(find.byValueKey('transfer-amount-input'));
  await driver.enterText(amount);
}
