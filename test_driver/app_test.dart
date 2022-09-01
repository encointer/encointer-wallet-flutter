import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'package:encointer_wallet/mocks/data/mock_account_data.dart';
import 'package:encointer_wallet/mocks/storage/mock_storage_setup.dart';
import 'package:encointer_wallet/utils/screenshot.dart';

void main() {
  FlutterDriver? driver;
  final config = Config();

  // use this for local testing
  // final config = Config(stagingDir: "./screenshots");

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // waits until the firs frame after ft startup stabilized
      await driver!.waitUntilFirstFrameRasterized();

      var ready = await driver!.requestData(MockStorageSetup.WAIT_UNTIL_APP_IS_READY);
      while (ready == false.toString()) {
        print("Waiting for app to be ready: $ready");
        await Future.delayed(const Duration(seconds: 1));
        ready = await driver!.requestData(MockStorageSetup.WAIT_UNTIL_APP_IS_READY);
      }

      await driver!.requestData(MockStorageSetup.INIT);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('importing account', () async {
      await driver!.tap(find.byValueKey('import-account'));

      // put focus on text field
      await driver!.tap(find.byValueKey('account-source'));
      await driver!.enterText(endoEncointer['mnemonic']);

      await driver!.tap(find.byValueKey('create-account-name'));
      await driver!.enterText(endoEncointer['name']);

      await driver!.tap(find.byValueKey('account-import-next'));

      await driver!.tap(find.byValueKey('create-account-pin'));
      await driver!.enterText(defaultPin);

      await driver!.tap(find.byValueKey('create-account-pin2'));
      await driver!.enterText(defaultPin);

      await driver!.tap(find.byValueKey('create-account-confirm'));
    });

    // Note: The second test continues where the first one ended
    test('choosing cid', () async {
      await driver!.tap(find.byValueKey('cid-0-marker-icon'));
      await driver!.tap(find.byValueKey('cid-0-marker-description'));

      // Here we get the metadata because it is reset to null in the setChosenCid() method which is called, when a community is chosen
      await driver!.requestData(MockStorageSetup.HOME_PAGE);
      // take a screenshot of the EncointerHome Screen
      await screenshot(driver!, config, 'encointer-home');
    }, timeout: const Timeout(Duration(seconds: 120))); // needed for android CI with github actions

    test('show receive qr code', () async {
      log('Future.delayed start');
      await Future.delayed(const Duration(seconds: 1));
      log('Future.delayed end');

      // await driver!.(find.byType('ModalBarrier'));
      log('ModalBarrier');
      // await driver!.tap(find.byType('AppBar'));
      // try {
      //   await driver!.waitFor(find.byType('AlertDialog'));
      //   log('find upgrader alert');
      //   await driver!.tap(find.text('IGNORE'));
      //   log('ignored upgrade app');
      // } catch (e) {
      //   log('upgader-alert  --> not found');
      // }

      await driver!.tap(find.byValueKey('qr-receive'));
      await screenshot(driver!, config, 'receive-funds');

      // go back to homepage
      await driver!.tap(find.byValueKey('close-receive-page'));
    });

    test('transfer-page', () async {
      // go to transfer page
      // await driver.tap(find.byValueKey('cid-asset'));

      print('---find transfer');
      await driver!.tap(find.byValueKey('transfer'));

      print('---find transfer-amount-input');
      await driver!.tap(find.byValueKey('transfer-amount-input'));

      print('---enter 3.4');
      await driver!.enterText('3.4');

      print('---screenshot transfer-page');
      await screenshot(driver!, config, 'transfer-page');

      // go back to homepage

      print('---close-transfer-page');
      await driver!.tap(find.byValueKey('close-transfer-page'));
    });

    test('meetupPage', () async {
      // attesting phase
      await driver!.requestData(MockStorageSetup.READY_FOR_MEETUP);

      log("tapping startMeetup");
      await driver!.tap(find.byValueKey('start-meetup'));
      await driver!.tap(find.byValueKey('attendees-count'));
      await driver!.enterText('3');
      await driver!.tap(find.byValueKey('ceremony-step-1-next'));
      await screenshot(driver!, config, 'claim-qr');
    });
  });
}

void log(String msg) {
  print("[test_driver] $msg");
}
