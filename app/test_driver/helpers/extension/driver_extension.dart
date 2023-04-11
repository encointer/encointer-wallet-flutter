import 'package:flutter_driver/flutter_driver.dart';

extension ScreenshotVariable on FlutterDriver {
  static final _shouldTakeScreenshot = Expando<bool>();

  bool get shouldTakeScreenshot => _shouldTakeScreenshot[this] ?? false;
  set shouldTakeScreenshot(bool x) => _shouldTakeScreenshot[this] = x;
}
