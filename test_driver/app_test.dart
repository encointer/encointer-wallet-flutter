import 'package:encointer_wallet/utils/screenshot.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  group('EncointerWallet App', () {

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // communicate to the app isolate how to setup the store
      // await driver.requestData(SETUP_STORE);

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

const SETUP_STORE = "setup_store";