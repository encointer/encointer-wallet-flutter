import 'package:encointer_wallet/utils/screenshot.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  group('EncointerWallet App', () {

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

    test('screenshot test', () async {
      final config = Config();
      await screenshot(driver, config, 'myscreenshot1');
    });
  });
}
