import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> receiveView(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('close-receive-page'));
  await driver.takeLocalScreenshot(Screenshots.receiveView);
  await driver.tap(find.byValueKey('close-receive-page'));
}
