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

  test('home-page', () async {
    await driver.scroll(find.byType('RefreshIndicator'), 20, 300, const Duration(seconds: 1));
    final findDialog = find.byType('AlertDialog').serialize();
    if (findDialog['type'] == 'AlertDialog') await driver.tap(find.text('IGNORE'));

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

    await driver.scrollUntilVisible(
      find.byValueKey('profile-list-view'),
      find.byValueKey('dev-mode'),
      dyScroll: -300.0,
    );

    await driver.tap(find.byValueKey('dev-mode'));

    await driver.scrollUntilVisible(
      find.byValueKey('profile-list-view'),
      find.byValueKey('next-phase-button'),
      dyScroll: -300.0,
    );

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
      await driver.scroll(find.byValueKey('drag-handle-panel'), 0, 300, const Duration(seconds: 1));
      await addDelay(1000);

      await driver.scroll(find.byType('RefreshIndicator'), 20, 300, const Duration(seconds: 1));
      await addDelay(1000);
    });
  });

  test('register-Alice', () async {
    await driver.scrollUntilVisible(
      find.byValueKey('list-view-wallet'),
      find.byValueKey('ceremony-box-wallet'),
      dyScroll: -300.0,
    );

    await driver.tap(find.byValueKey('registration-meetup-button'));
    await driver.waitFor(find.byValueKey('is-registered-info'));

    await driver.scrollUntilVisible(
      find.byValueKey('list-view-wallet'),
      find.byValueKey('panel-controller'),
      dyScroll: 300.0,
    );
    await addDelay(1000);
  });

  test('import and register-Bob', () async {
    await driver.tap(find.byValueKey('panel-controller'));
    await driver.tap(find.byValueKey('add-account-panel'));

    await driver.waitFor(find.byValueKey('import-account'));
    await driver.tap(find.byValueKey('import-account'));

    await driver.waitFor(find.byValueKey('create-account-name'));
    await driver.tap(find.byValueKey('create-account-name'));
    await driver.enterText('Bob');

    await driver.tap(find.byValueKey('account-source'));
    await driver.enterText('//Bob');

    await driver.tap(find.byValueKey('account-import-next'));
    await driver.waitFor(find.byValueKey('panel-controller'));

    await driver.scrollUntilVisible(
      find.byValueKey('list-view-wallet'),
      find.byValueKey('ceremony-box-wallet'),
      dyScroll: -300.0,
    );

    await driver.tap(find.byValueKey('registration-meetup-button'));
    await driver.waitFor(find.byValueKey('is-registered-info'));

    await driver.scrollUntilVisible(
      find.byValueKey('list-view-wallet'),
      find.byValueKey('panel-controller'),
      dyScroll: 300.0,
    );
    await addDelay(1000);
  });

  test('import and register-Charlie', () async {
    await driver.tap(find.byValueKey('panel-controller'));
    await driver.tap(find.byValueKey('add-account-panel'));

    await driver.waitFor(find.byValueKey('import-account'));
    await driver.tap(find.byValueKey('import-account'));

    await driver.waitFor(find.byValueKey('create-account-name'));
    await driver.tap(find.byValueKey('create-account-name'));
    await driver.enterText('Charlie');

    await driver.tap(find.byValueKey('account-source'));
    await driver.enterText('//Charlie');

    await driver.tap(find.byValueKey('account-import-next'));
    await driver.waitFor(find.byValueKey('panel-controller'));

    await driver.scrollUntilVisible(
      find.byValueKey('list-view-wallet'),
      find.byValueKey('ceremony-box-wallet'),
      dyScroll: -300.0,
    );

    await driver.tap(find.byValueKey('registration-meetup-button'));
    await driver.waitFor(find.byValueKey('is-registered-info'));

    await driver.scrollUntilVisible(
      find.byValueKey('list-view-wallet'),
      find.byValueKey('panel-controller'),
      dyScroll: 300.0,
    );
    await addDelay(1000);
  });

  test('get attesting-phase', () async {
    await driver.tap(find.byValueKey('Profile'));

    await driver.scrollUntilVisible(
      find.byValueKey('profile-list-view'),
      find.byValueKey('next-phase-button'),
      dyScroll: -300.0,
    );

    await driver.tap(find.byValueKey('next-phase-button'));
    await driver.waitFor(find.byType('SnackBar'));

    await driver.tap(find.byValueKey('next-phase-button'));
    await driver.waitFor(find.byType('SnackBar'));

    await driver.tap(find.byValueKey('Wallet'));
    await addDelay(1000);
  });

  test('start meetup-Cahrlie', () async {
    await driver.scrollUntilVisible(
      find.byValueKey('profile-list-view'),
      find.byValueKey('start-meetup'),
      dyScroll: -300.0,
    );

    await driver.tap(find.byValueKey('start-meetup'));
    await addDelay(500);

    await driver.waitFor(find.byValueKey('attendees-count'));
    await driver.tap(find.byValueKey('attendees-count'));
    await driver.enterText('3');
    await addDelay(500);
    await driver.tap(find.byValueKey('ceremony-step-1-next'));

    await driver.waitFor(find.byValueKey('attest-all-participants-dev'));
    await driver.tap(find.byValueKey('attest-all-participants-dev'));
    await addDelay(500);
    await driver.waitFor(find.byType('SnackBar'));
    await driver.tap(find.byValueKey('close-meetup'));

    await driver.waitFor(find.byValueKey('submit-claims'));
    await driver.tap(find.byValueKey('submit-claims'));
    await addDelay(500);

    await driver.waitFor(find.byValueKey('panel-controller'));
    await driver.scrollUntilVisible(
      find.byValueKey('profile-list-view'),
      find.byValueKey('panel-controller'),
      dyScroll: 300.0,
    );
    await addDelay(5000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}
