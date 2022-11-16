import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/add_delay.dart';
import 'helpers/real_app_helper.dart';

// [ANDROID] flutter drive --target=test_driver/real_app.dart --flavor dev
// [IOS] flutter drive --target=test_driver/real_app.dart

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

  test('home-page', () async {
    await refreshWalletPage(driver);
    await dismissUpgradeDialogOnAndroid(driver);

    await addDelay(1000);
  });

  test('qr-receive page', () async {
    await driver.tap(find.byValueKey('qr-receive'));
    await addDelay(1000);
    await driver.tap(find.byValueKey('close-receive-page'));
    await addDelay(1000);
  });

  test('transfer-page', () async {
    await driver.tap(find.byValueKey('transfer'));
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
    await addDelay(1000);

    await driver.tap(find.byValueKey('Wallet'));
    await addDelay(1000);
  });

  test('turn on dev-mode', () async {
    await driver.tap(find.byValueKey('Profile'));

    await scrollToDevMode(driver);

    await driver.tap(find.byValueKey('dev-mode'));

    await scrollToNextPhaseButton(driver);

    await addDelay(1000);
  });

  test('change-network', () async {
    await driver.tap(find.byValueKey('choose-network'));

    await driver.tap(find.byValueKey('nctr-gsl-dev'));
    await driver.tap(find.text('Alice'));

    await driver.waitFor(find.byValueKey('profile-list-view'));

    await driver.tap(find.byValueKey('Wallet'));
    await addDelay(1000);
  });

  test('change-community', () async {
    await driver.runUnsynchronized(() async {
      await driver.tap(find.byValueKey('panel-controller'));
      await driver.tap(find.byValueKey('add-community'));
      await addDelay(1000);

      await driver.tap(find.byValueKey('cid-0-marker-icon'));
      await driver.tap(find.byValueKey('cid-0-marker-description'));
      await addDelay(1000);

      await driver.waitFor(find.byValueKey('add-community'));
      await addDelay(1000);
      await closePanel(driver);
      await addDelay(1000);

      await refreshWalletPage(driver);
      await addDelay(1000);
    });
  });

  test('register-Alice', () async {
    await addDelay(1500);
    await scrollToCeremonyBox(driver);

    await registerAndWait(driver);

    await scrollToPanelController(driver);
    await addDelay(1000);
  });

  test('import and register-Bob', () async {
    await importAccountAndRegisterMeetup(driver, 'Bob');
  });

  test('import and register-Charlie', () async {
    await importAccountAndRegisterMeetup(driver, 'Charlie');
  });

  test('get attesting-phase', () async {
    await driver.tap(find.byValueKey('Profile'));

    await scrollToNextPhaseButton(driver);

    await tapAndWaitNextPhase(driver);

    await tapAndWaitNextPhase(driver);

    await driver.tap(find.byValueKey('Wallet'));
    await addDelay(1000);
  });

  test('start meetup-Cahrlie', () async {
    await addDelay(1000);
    await startMeetupTest(driver);
  });

  test('start meetup-Bob', () async {
    await addDelay(1000);
    await changeAccountFromPanel(driver, 'Bob');
    await startMeetupTest(driver);
    await addDelay(1000);
  });

  test('start meetup-Alice', () async {
    await addDelay(1000);
    await changeAccountFromPanel(driver, 'Alice');
    await startMeetupTest(driver);
    await driver.waitFor(find.byValueKey('claim-pending-dev'));
    await driver.tap(find.byValueKey('claim-pending-dev'));
    await addDelay(20000);
  }, timeout: const Timeout(Duration(seconds: 100)));

  tearDownAll(() async {
    await driver.close();
  });
}
