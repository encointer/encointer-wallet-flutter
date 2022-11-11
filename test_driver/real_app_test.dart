import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/add_delay.dart';

// flutter drive --target=test_driver/real_app.dart --flavor dev

void main() async {
  late FlutterDriver driver;

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('importing account', () async {
    await driver.tap(find.byValueKey('import-account'));

    await driver.tap(find.byValueKey('account-source'));
    await driver.enterText('//Alice');

    await driver.tap(find.byValueKey('create-account-name'));
    await driver.enterText('Alice');

    await driver.tap(find.byValueKey('account-import-next'));

    await driver.tap(find.byValueKey('create-account-pin'));
    await driver.enterText('0001');

    await driver.tap(find.byValueKey('create-account-pin2'));
    await driver.enterText('0001');

    await driver.tap(find.byValueKey('create-account-confirm'));
  });

  test('choosing cid', () async {
    await driver.tap(find.byValueKey('cid-1-marker-icon'));
    await driver.tap(find.byValueKey('cid-1-marker-description'));
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('home page', () async {
    await driver.scroll(find.byType('RefreshIndicator'), 20, 300, const Duration(seconds: 1));
    await addDelay(1500);
  });

  test('qr-receive page', () async {
    await driver.tap(find.byValueKey('qr-receive'));
    await addDelay(1000);
    await driver.tap(find.byValueKey('close-receive-page'));
    await addDelay(1000);
  });

  test('transfer-page', () async {
    await driver.tap(find.byValueKey('transfer'));
    await addDelay(1000);
    await driver.tap(find.byValueKey('transfer-amount-input'));

    await driver.enterText('3.4');
    await addDelay(1000);
    await driver.tap(find.byValueKey('close-transfer-page'));
    await addDelay(1000);
  });

  test('contact-page', () async {
    await driver.tap(find.byValueKey('Contacts'));
    await driver.tap(find.byValueKey('add-contact'));

    await driver.tap(find.byValueKey('contact-address'));
    await driver.enterText('5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');
    await driver.tap(find.byValueKey('contact-name'));
    await driver.enterText('Eldiar');
    await driver.tap(find.byValueKey('contact-save'));
    await addDelay(1500);
    
    await driver.tap(find.byValueKey('Wallet'));
    await addDelay(5000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}
