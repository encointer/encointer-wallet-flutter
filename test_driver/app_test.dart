import 'package:encointer_wallet/mocks/data/mockAccountData.dart';
import 'package:encointer_wallet/mocks/storage/mockStorageSetup.dart';
import 'package:encointer_wallet/utils/screenshot.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  final config = Config();

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // waits until the firs frame after ft startup stabilized
      await driver.waitUntilFirstFrameRasterized();
      await driver.requestData(MockStorageSetup.INIT);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('importing account', () async {
      await driver.tap(find.byValueKey('import-account'));

      // put focus on text field
      await driver.tap(find.byValueKey('account-source'));
      await driver.enterText(endoEncointer['mnemonic']);

      await driver.tap(find.byValueKey('create-account-name'));
      await driver.enterText(endoEncointer['name']);

      await driver.tap(find.byValueKey('account-import-next'));

      await driver.tap(find.byValueKey('create-account-pin'));
      await driver.enterText(defaultPin);

      await driver.tap(find.byValueKey('create-account-pin2'));
      await driver.enterText(defaultPin);

      await driver.tap(find.byValueKey('create-account-confirm'));
    });

    // Note: The second test continues where the first one ended
    test('choosing cid', () async {
      await driver.tap(find.byValueKey('cid-0-marker-icon'));
      await driver.tap(find.byValueKey('cid-0-marker-description'));

      // Here we get the metadata because it is reset to null in the setChosenCid() method which is called, when a community is chosen
      await driver.requestData(MockStorageSetup.GET_METADATA);
      // take a screenshot of the EncointerHome Screen
      await screenshot(driver, config, 'encointer-home');
    }, timeout: Timeout(Duration(seconds: 120))); // needed for android CI with github actions

    test('show receive qr code', () async {
      await driver.tap(find.byValueKey('qr-receive'));
      await screenshot(driver, config, 'receive-funds');

      // go back to homepage
      await driver.tap(find.byValueKey('close-receive-page'));
    });

    test('transfer-page', () async {
      // go to transfer page
      // await driver.tap(find.byValueKey('cid-asset'));

      print('---find transfer');
      await driver.tap(find.byValueKey('transfer'));

      print('---find transfer-amount-input');
      await driver.tap(find.byValueKey('transfer-amount-input'));

      print('---enter 3.4');
      await driver.enterText('3.4');

      print('---screenshot transfer-page');
      await screenshot(driver, config, 'transfer-page');

      // go back to homepage

      print('---close-transfer-page');
      await driver.tap(find.byValueKey('close-transfer-page'));
    });

    test('encointerEntryPage', () async {
      log("tapping encointerEntry tap");
      // key is directly derived by `TabKey` enum to string
      await driver.tap(find.byValueKey('TabKey.Ceremonies'));

      // communicate to the app isolate how to setup the store
      await driver.requestData(MockStorageSetup.UNREGISTERED_PARTICIPANT);
      await screenshot(driver, config, 'register-participant-page');

      // attesting phase
      await driver.requestData(MockStorageSetup.READY_FOR_MEETUP);
      await screenshot(driver, config, 'attesting-page');
    });

    test('meetupPage', () async {
      log("tapping startMeetup");
      await driver.tap(find.byValueKey('start-meetup'));
      await driver.tap(find.byValueKey('confirmed-participants-3'));
      await screenshot(driver, config, 'claim-qr');
    });
  });
}

void log(String msg) {
  print("[test_driver] $msg");
}
