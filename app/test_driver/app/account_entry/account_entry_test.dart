import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> checkAcoountEntryView(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccount));
  await driver.takeLocalScreenshot(Screenshots.accountEntryView);
}
