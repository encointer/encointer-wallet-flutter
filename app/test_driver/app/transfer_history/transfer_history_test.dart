import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> checkTransferHistoryEmpty(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('transactions-empty'));
  await driver.takeLocalScreenshot(Screenshots.txHistoryEmpty);
  await driver.tap(find.pageBack());
}

Future<void> checkTransferHistory(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('transactions-list'));
  await driver.takeLocalScreenshot(Screenshots.txHistory);
  await driver.tap(find.pageBack());
}
