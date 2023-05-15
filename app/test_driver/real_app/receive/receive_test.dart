import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver_extension.dart';
import '../../helpers/screenshots/screenshots.dart';

Future<void> receiveView(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('close-receive-page'));
  await driver.takeScreenshot(Screenshots.receiveView);
  await driver.tap(find.byValueKey('close-receive-page'));
}
