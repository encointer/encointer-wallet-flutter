import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> checkAcoountEntryView(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('create-account'));
  await driver.takeScreenshot(Screenshots.accountEntryView);
}
