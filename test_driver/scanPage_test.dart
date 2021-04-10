import 'dart:io';

import 'package:encointer_wallet/utils/screenshot.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  final config = Config();

  group('scan-page', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // waits until the firs frame after ft startup stabilized
      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('scan-page-screenshot', () async {
      sleep(Duration(seconds: 10));
      await screenshot(driver, config, 'scan-receive');
    });
  });
}
