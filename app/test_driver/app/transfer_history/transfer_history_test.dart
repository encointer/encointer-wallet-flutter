import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> checkTransferHistoryEmpty(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.transactionsEmpty));
  await driver.takeLocalScreenshot(Screenshots.txHistoryEmpty);
  await driver.tap(find.pageBack());
}

Future<void> checkTransferHistory(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.transactionsList));
  await driver.takeLocalScreenshot(Screenshots.txHistory);
  await driver.tap(find.pageBack());
}
