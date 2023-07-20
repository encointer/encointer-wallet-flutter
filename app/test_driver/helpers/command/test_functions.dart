import 'package:flutter_driver/flutter_driver.dart';

Future<bool> isWidgetPresent(
  SerializableFinder byValueKey,
  FlutterDriver driver, {
  Duration timeout = const Duration(seconds: 3),
}) async {
  try {
    await driver.waitFor(byValueKey, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}
