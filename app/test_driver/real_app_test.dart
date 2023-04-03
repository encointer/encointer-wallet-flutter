import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/add_delay.dart';
import 'helpers/other_test.dart';
import 'helpers/real_app_helper.dart';
import 'helpers/screenshots.dart';

void main() async {
  late FlutterDriver driver;

  var publicKey = '';

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('create account by name Tom', () async {
    await takeScreenshot(driver, Screenshots.splashView);
    await driver.waitFor(find.byValueKey('create-account'));
    await takeScreenshot(driver, Screenshots.accountEntryView);
    await createAccountAndSetPin(driver, 'Tom');
  });

  test('choosing cid', () async {
    await driver.waitFor(find.byValueKey('cid-0-marker-icon'));
    await driver.tap(find.byValueKey('cid-0-marker-icon'));
    await driver.waitFor(find.byValueKey('cid-0-marker-description'));
    await takeScreenshot(driver, Screenshots.chooseCommunityMap);
    await driver.tap(find.byValueKey('cid-0-marker-description'));
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('home-page', () async {
    await refreshWalletPage(driver);

    await dismissUpgradeDialogOnAndroid(driver);
    await takeScreenshot(driver, Screenshots.homeWithRegisterButton);
    await addDelay(1000);
  });

  test('qr-receive page', () async {
    await driver.tap(find.byValueKey('qr-receive'));
    await driver.waitFor(find.byValueKey('close-receive-page'));
    await takeScreenshot(driver, Screenshots.receiveView);
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
    await driver.tap(find.text('Tom'));

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

  test('import account Alice', () async {
    await importAccount(driver, 'Alice', shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Register [Bootstrapper] Alice', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, 'Bootstrapper');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Unregister [Bootstrapper] Alice', () async {
    await unregisterAndWait(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Register [Bootstrapper] Alice again', () async {
    await registerAndWait(driver, 'Bootstrapper');
    await scrollToPanelController(driver);
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('send money to Tom', () async {
    await driver.tap(find.byValueKey('transfer'));
    await driver.waitFor(find.byValueKey('transfer-listview'));
    await driver.tap(find.byValueKey('transfer-amount-input'));

    await driver.enterText('0.1');
    await driver.tap(find.byValueKey('transfer-select-account'));
    await driver.waitFor(find.byValueKey('Tom'));
    await driver.tap(find.byValueKey('Tom'));
    await takeScreenshot(driver, Screenshots.sendView);

    await driver.runUnsynchronized(() async {
      await driver.waitFor(find.byValueKey('make-transfer'));
      await driver.tap(find.byValueKey('make-transfer'));

      await driver.waitFor(find.byValueKey('make-transfer-send'));
      await driver.tap(find.byValueKey('make-transfer-send'));
      await driver.waitFor(find.byValueKey('transfer-done'));
      await takeScreenshot(driver, Screenshots.txConfirmationView);
      await driver.tap(find.byValueKey('transfer-done'));
      await addDelay(1000);
    });
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Register [Newbie] Tom', () async {
    await changeAccountFromPanel(driver, 'Tom');
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, 'Newbie', shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Unregister [Newbie] Tom', () async {
    await unregisterAndWait(driver, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Register [Newbie] Tom again', () async {
    await registerAndWait(driver, 'Newbie');
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('import account Charlie', () async {
    await importAccount(driver, 'Charlie');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('import and register-Bob', () async {
    await importAccountAndRegisterMeetup(driver, 'Bob');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('get assignin-phase', () async {
    await driver.tap(find.byValueKey('profile'));
    await scrollToNextPhaseButton(driver);

    await tapAndWaitNextPhase(driver);
    await driver.tap(find.byValueKey('wallet'));
    await driver.waitFor(find.byValueKey('list-view-wallet'));
    await scrollToCeremonyBox(driver);
    await driver.waitFor(find.byValueKey('account-assigned'));
    await takeScreenshot(driver, Screenshots.homeAssigningPhaseAssigned);
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Charlie');
    await scrollToCeremonyBox(driver);
    await driver.waitFor(find.byValueKey('account-unassigned'));
    await takeScreenshot(driver, Screenshots.homeAssigningPhaseUnassigned);
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Bob');
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 40)));

  test('get attesting-phase', () async {
    await driver.tap(find.byValueKey('profile'));
    await scrollToNextPhaseButton(driver);

    await tapAndWaitNextPhase(driver);
    await driver.tap(find.byValueKey('wallet'));
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 40)));

  test('start meetup-Bob', () async {
    await addDelay(1000);
    await changeAccountFromPanel(driver, 'Bob');
    await startMeetupTest(driver);
    await addDelay(1000);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('start meetup-Tom', () async {
    await addDelay(1000);
    await changeAccountFromPanel(driver, 'Tom');
    await startMeetupTest(driver, shouldTakeScreenshot: true);
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

  test('contact-page add contact', () async {
    await driver.tap(find.byValueKey('contacts'));
    await takeScreenshot(driver, Screenshots.contactsOverviewEmpty);
    await driver.tap(find.byValueKey('add-contact'));

    await driver.tap(find.byValueKey('contact-address'));
    await driver.enterText('5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');
    await driver.tap(find.byValueKey('contact-name'));
    await driver.enterText('Obelix');

    await takeScreenshot(driver, Screenshots.addContact);
    await driver.tap(find.byValueKey('contact-save'));
    await addDelay(1000);
  });

  test('change contact name', () async {
    await driver.waitFor(find.byValueKey('Obelix'));
    await driver.tap(find.byValueKey('Obelix'));

    await driver.waitFor(find.byValueKey('contact-name-edit'));
    await takeScreenshot(driver, Screenshots.contactView);
    await driver.tap(find.byValueKey('contact-name-edit'));

    await driver.waitFor(find.byValueKey('contact-name-field'));
    await driver.tap(find.byValueKey('contact-name-field'));

    await driver.enterText('Asterix');
    await takeScreenshot(driver, Screenshots.changeContactName);
    await driver.tap(find.byValueKey('contact-name-edit-check'));

    await driver.waitFor(find.text('Asterix'));
    await addDelay(1000);
  });

  test('send endorse to account', () async {
    await driver.waitFor(find.byValueKey('tap-endorse-button'));
    await driver.tap(find.byValueKey('tap-endorse-button'));
    await addDelay(1000);
  });

  test('send money to account from Bootstraper account', () async {
    await driver.waitFor(find.byValueKey('send-money-to-account'));
    await driver.tap(find.byValueKey('send-money-to-account'));

    await sendMoneyToAccount(driver);
    await driver.tap(find.byValueKey('wallet'));
  });

  test('delete account Bob', () async {
    await driver.tap(find.byValueKey('profile'));
    await deleteAccountFromAccountManagePage(driver, 'Bob');
  });

  test('delete account Charlie', () async {
    await deleteAccountFromAccountManagePage(driver, 'Charlie');
    await driver.tap(find.byValueKey('wallet'));
  });

  test('create niewbie Account', () async {
    await addDelay(1000);
    await createNewbieAccount(driver, 'Li');
    await changeAccountFromPanel(driver, 'Tom');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('get public key', () async {
    await driver.tap(find.byValueKey('profile'));
    await driver.waitFor(find.byValueKey('Li'));
    await driver.tap(find.byValueKey('Li'));
    await driver.waitFor(find.byValueKey('account-public-key'));
    await addDelay(1000);
    publicKey = await driver.getText(find.byValueKey('account-public-key'));
    await driver.tap(find.byValueKey('close-account-manage'));
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('contact-page add account Li', () async {
    await driver.tap(find.byValueKey('contacts'));
    await driver.tap(find.byValueKey('add-contact'));

    await driver.tap(find.byValueKey('contact-address'));
    await driver.enterText(publicKey);
    await driver.tap(find.byValueKey('contact-name'));
    await driver.enterText('Li');

    await driver.tap(find.byValueKey('contact-save'));
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('send endorse to account from Reputable', () async {
    await driver.waitFor(find.byValueKey('Li'));
    await driver.tap(find.byValueKey('Li'));

    await driver.waitFor(find.byValueKey('tap-endorse-button'));
    await driver.tap(find.byValueKey('tap-endorse-button'));
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('send money to account from Reputable account', () async {
    await driver.waitFor(find.byValueKey('send-money-to-account'));
    await driver.tap(find.byValueKey('send-money-to-account'));

    await sendMoneyToAccount(driver);
    await takeScreenshot(driver, Screenshots.contactsOverview);
    await driver.tap(find.byValueKey('wallet'));
  });

  test('register Tom (check status as Reputable)', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, 'Reputable');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Unregister [Reputable] Tom', () async {
    await unregisterAndWait(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Register [Reputable] Tom again', () async {
    await registerAndWait(driver, 'Reputable');
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('register Li (check status as Endorsee)', () async {
    await changeAccountFromPanel(driver, 'Li');
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, 'Endorsee');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Unregister [Endorsee] Li', () async {
    await unregisterAndWait(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Register [Newbie-Endorsee] Li again', () async {
    await registerAndWait(driver, 'Newbie');
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account share', () async {
    await changeAccountFromPanel(driver, 'Tom');
    await shareAccount(driver, 'Tom', shouldTakeScreenshot: true);
    await addDelay(2500);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account change name', () async {
    await accountChangeName(driver, 'Jerry', shouldTakeScreenshot: true);
    await addDelay(500);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account export', () async {
    await accountExport(driver, shouldTakeScreenshot: true);
    await addDelay(500);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account delete from account manage page', () async {
    await accountDeleteFromAccountManagePage(driver);
    await addDelay(500);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('delete all account ad show create account page', () async {
    await rmAllAccountsFromProfilePage(driver);
    await addDelay(2000);
  });

  tearDownAll(() async {
    await driver.close();
  });
}
