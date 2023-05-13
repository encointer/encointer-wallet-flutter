import 'package:flutter_driver/flutter_driver.dart';

Future<void> refreshWalletPage(FlutterDriver driver) async {
  await driver.scroll(find.byType('RefreshIndicator'), 20, 300, const Duration(seconds: 1));
}

Future<void> closePanel(FlutterDriver driver) async {
  await driver.scroll(find.byValueKey('drag-handle-panel'), 0, 300, const Duration(seconds: 1));
}

Future<void> changeAccountFromPanel(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));
  await closePanel(driver);
}
