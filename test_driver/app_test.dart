import 'package:encointer_wallet/mocks/data/mockAccountData.dart';
import 'package:encointer_wallet/mocks/storage/storageSetup.dart';
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

    test('importing account', () async {
      log("tap import account...");
      await driver.tap(find.byValueKey('import-account'));

      log("entering mnemonic...");
      // put focus on text field
      await driver.tap(find.byValueKey('account-source'));
      await driver.enterText(endoEncointer['mnemonic']);

      log("tap import confirm");
      final importAccountOk = find.byValueKey('account-import-next');
      await driver.tap(importAccountOk);

      log("setting account name");
      // put focus on text field
      await driver.tap(find.byValueKey('create-account-name'));
      await driver.enterText(endoEncointer['name']);

      log("setting account pin");
      // put focus on text field
      await driver.tap(find.byValueKey('create-account-pin'));
      await driver.enterText(defaultPin);

      log("confirming account pin");
      // put focus on text field
      await driver.tap(find.byValueKey('create-account-pin2'));
      await driver.enterText(defaultPin);

      log("creating account");
      await driver.tap(find.byValueKey('create-account-confirm'));
    });

    test('choosing cid', () async {
      log("tapping cid dropdown");
      await driver.tap(find.byValueKey('cid-dropdown'));
      log("choosing cid");
      await driver.tap(find.byValueKey('cid-0'));

      // take a screenshot of the EncointerHome Screen
      final config = Config();
      await screenshot(driver, config, 'wallet-tab');
    });


    test('switch to encointerEntryPage', () async {
      log("tapping encointerEntry tap");
      await driver.tap(find.byValueKey('tab-ceremonies'));

      // communicate to the app isolate how to setup the store
      await driver.requestData(StorageSetup.UNREGISTERED_PARTICIPANT);

      // should be registering

      // log("choosing cid");
      // await driver.tap(find.byValueKey('cid-0'));
      //
      // take a screenshot of the EncointerHome Screen
      final config = Config();
      await screenshot(driver, config, 'wallet-tab');
    });

  });
}


void log(String msg) {
  print("[test_driver] $msg");
}