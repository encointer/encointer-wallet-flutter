import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/add_delay.dart';
import 'helpers/other_test.dart';
import 'helpers/real_app_helper.dart';

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

  test('turn on dev-mode', () async {
    await driver.tap(find.byValueKey('profile'));

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

    await driver.tap(find.byValueKey('wallet'));
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 90)));

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
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('import and register-Bob', () async {
    await importAccountAndRegisterMeetup(driver, 'Bob');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('import and register-Charlie', () async {
    await importAccountAndRegisterMeetup(driver, 'Charlie');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('get attesting-phase', () async {
    await driver.tap(find.byValueKey('profile'));

    await scrollToNextPhaseButton(driver);

    await tapAndWaitNextPhase(driver);

    await tapAndWaitNextPhase(driver);

    await driver.tap(find.byValueKey('wallet'));
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 40)));

  test('start meetup-Cahrlie', () async {
    await addDelay(1000);
    await startMeetupTest(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('start meetup-Bob', () async {
    await addDelay(1000);
    await changeAccountFromPanel(driver, 'Bob');
    await startMeetupTest(driver);
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('start meetup-Alice', () async {
    await addDelay(1000);
    await changeAccountFromPanel(driver, 'Alice');
    await startMeetupTest(driver);
    await driver.waitFor(find.byValueKey('claim-pending-dev'));
    await driver.tap(find.byValueKey('claim-pending-dev'));
    await addDelay(20000);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Go to Profile Page and Check reputation count', () async {
    await driver.tap(find.byValueKey('profile'));
    await driver.waitFor(find.text('2'));
    await addDelay(1000);
    await scrollToNextPhaseButton(driver);
    await tapAndWaitNextPhase(driver);
    await driver.tap(find.byValueKey('wallet'));
  });

  test('contact-page add account', () async {
    await driver.tap(find.byValueKey('contacts'));
    await driver.tap(find.byValueKey('add-contact'));

    await driver.tap(find.byValueKey('contact-address'));
    await driver.enterText('5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');
    await driver.tap(find.byValueKey('contact-name'));
    await driver.enterText('Sezar');

    await driver.tap(find.byValueKey('contact-save'));
    await addDelay(1000);
  });

  test('send endorse to account', () async {
    await driver.waitFor(find.byValueKey('Sezar'));
    await driver.tap(find.byValueKey('Sezar'));

    await driver.waitFor(find.byValueKey('tap-endorse-button'));
    await driver.tap(find.byValueKey('tap-endorse-button'));
    await addDelay(1000);
  });

  test('send money to account', () async {
    await driver.waitFor(find.byValueKey('send-money-to-account'));
    await driver.tap(find.byValueKey('send-money-to-account'));

    await sendMoneyToAccount(driver);
    await driver.tap(find.byValueKey('wallet'));
  });

  test('create newbie account', () async {
    await createNewbieAccountAndSendMoney(driver, 'Tom');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account share and change name', () async {
    await shareAccountAndChangeNameTest(driver, 'Tom', 'Jerry');
    await addDelay(2500);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('delete all account ad show create account page', () async {
    await rmAllAccountsFromProfilePage(driver);
    await addDelay(2000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}
