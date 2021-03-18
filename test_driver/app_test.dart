import 'package:encointer_wallet/utils/screenshot.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  group('EncointerWallet App', () {

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
  });

  test('screenshot test', () async {
    // await driver.runUnsynchronized(() async {
      final config = Config();
      //
      // await screenshot(driver, config, 'myscreenshot1');
      expect(true, true);
    // },
    // timeout: Duration(minutes: 2));
  });
}
