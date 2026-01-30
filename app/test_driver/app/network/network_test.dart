import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> changeDevNetwork(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.nctrGslDev));
  await driver.tap(find.byValueKey(EWTestKeys.nctrGslDev));
  await driver.tap(find.text(account));
  await driver.waitFor(find.byValueKey(EWTestKeys.profileListView));
}
