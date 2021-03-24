import 'dart:io';

import 'package:encointer_wallet/mocks/data/MockAccountData.dart';
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

    test('importing account', () async {
      log("tap import account...");
      final importAccount = find.byValueKey('import-account');
      await driver.tap(importAccount);

      log("entering mnemonic...");
      final accountSource = find.byValueKey('account-source');
      await driver.tap(accountSource);
      await driver.enterText(endoEncointer['mnemonic']);

      log("tap import confirm");
      final importAccountOk = find.byValueKey('account-import-next');
      await driver.tap(importAccountOk);

      sleep(Duration(seconds: 10));
    });

    //
    // test('screenshot test', () async {
    //   final passwordTextFinder = find.byValueKey('password-input-field');
    //   driver.tap(passwordTextFinder);
    //   await driver.enterText("1234");
    //   final okButtonFinder = find.byValueKey('password-ok');
    //   await driver.tap(okButtonFinder);
    //
    //   final config = Config();
    //   await screenshot(driver, config, 'myscreenshot1');
    // });
  });
}

const SETUP_STORE = "setup_store";

void log(String msg) {
  print("[test_driver] $msg");
}