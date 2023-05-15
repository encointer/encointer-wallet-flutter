import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/command/real_app_command.dart';
import 'helpers/extension/screenshot_driver_extension.dart';
import 'helpers/participant_type.dart';
import 'real_app/real_app.dart';

void main() async {
  late FlutterDriver driver;

  // var publicKey = '';
  // var menemonic = '';

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      driver.shouldTakeScreenshot = await driver.requestData(RealAppTestCommand.shouldTakeScreenshot);
      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('create account by name Tom', () async {
    await checkAcoountEntryView(driver);
    await goCreateAccountViewFromAcoountEntryView(driver);
    await createAccount(driver, 'Tom');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('create PIN by text 0001', () async {
    await createPin(driver, '0001');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('choosing cid', () async {
    await choosingCid(driver, 0);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('home-page', () async {
    await homeInit(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('qr-receive page', () async {
    await goReceiveViewFromHomeView(driver);
    await receiveView(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('turn on dev-mode', () async {
    await goProfileViewFromNavBar(driver);
    await turnDevMode(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('change-network', () async {
    await goToNetwotkView(driver);
    await changeDevNetwork(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('change-community', () async {
    await goHomeViewFromNavBar(driver);
    await changeCommunity(driver);
  });

  test('import account Alice', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Alice', '//Alice');
    await closePanel(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Register [Bootstrapper] Alice', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Unregister [Bootstrapper] Alice', () async {
    await scrollToCeremonyBox(driver);
    await unregisterAndWait(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Register [Bootstrapper] Alice again', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('send money to Tom', () async {
    await goToTransferViewFromHomeView(driver);
    await senMoneyToAccount(driver, 'Tom', '0.1');
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Register [Newbie] Tom', () async {
    await changeAccountFromPanel(driver, 'Tom');
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.newbie, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Unregister [Newbie] Tom', () async {
    await scrollToCeremonyBox(driver);
    await unregisterAndWait(driver, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('Register [Newbie] Tom again', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.newbie);
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('import account Charlie', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Charlie', '//Charlie');
    await closePanel(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('import and register-Bob', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Bob', '//Bob');
    await closePanel(driver);
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('get assignin-phase', () async {
    await goProfileViewFromNavBar(driver);
    await getNextPhase(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('check assignin-phase account Assigned', () async {
    await goHomeViewFromNavBar(driver);
    await checkAssignPhaseAssigned(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('check assignin-phase account Unassigned', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Charlie');
    await checkAssignPhaseUnassigned(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('get attesting-phase', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Bob');
    await goProfileViewFromNavBar(driver);
    await getNextPhase(driver);
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('start meetup-Bob', () async {
    await goHomeViewFromNavBar(driver);
    await scrollToStartMeetup(driver);
    await startMeetupTest(driver);
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('start meetup-Tom', () async {
    await changeAccountFromPanel(driver, 'Tom');
    await scrollToStartMeetup(driver);
    await startMeetupTest(driver, shouldTakeScreenshot: true);
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('start meetup-Alice', () async {
    await changeAccountFromPanel(driver, 'Alice');
    await scrollToStartMeetup(driver);
    await startMeetupTest(driver);
    await scrollToPanelController(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Claim-pending (dev-mode)', () async {
    await claimPendingDev(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Go to Profile Page and Check reputation count', () async {
    await goProfileViewFromNavBar(driver);
    await checkPeputationCount(driver, 2);
  });

  test('Get Registering phase', () async {
    await getNextPhase(driver);
  });

  // test('contact-page add contact', () async {
  //   await driver.tap(find.byValueKey('contacts'));
  //   await driver.takeScreenshot(Screenshots.contactsOverviewEmpty);
  //   await driver.tap(find.byValueKey('add-contact'));

  //   await driver.takeScreenshot(Screenshots.addContact);
  //   await enterConatctNamePubkey(driver, 'Obelix', '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');
  //   // await driver.takeScreenshot(Screenshots.addContact);
  //   await driver.tap(find.byValueKey('contact-save'));
  // });

  // test('change contact name', () async {
  //   await driver.waitFor(find.byValueKey('Obelix'));
  //   await driver.tap(find.byValueKey('Obelix'));
  //   await driver.waitFor(find.byValueKey('contact-name-edit'));
  //   await driver.takeScreenshot(Screenshots.contactView);
  //   await enterChangeContactName(driver, 'Asterix');
  //   // await driver.takeScreenshot(Screenshots.changeContactName);
  //   await driver.tap(find.byValueKey('contact-name-edit-check'));
  //   await driver.waitFor(find.text('Asterix'));
  // });

  // test('send endorse to account', () async {
  //   await driver.waitFor(find.byValueKey('tap-endorse-button'));
  //   await driver.tap(find.byValueKey('tap-endorse-button'));
  // });

  // test('send money to account from Bootstraper account', () async {
  //   await driver.waitFor(find.byValueKey('send-money-to-account'));
  //   await driver.tap(find.byValueKey('send-money-to-account'));

  //   await sendMoneyToAccount(driver);
  //   await driver.tap(find.byValueKey('wallet'));
  // });

  // test('delete account Bob', () async {
  //   await driver.tap(find.byValueKey('profile'));
  //   await deleteAccountFromAccountManagePage(driver, 'Bob');
  // });

  // test('delete account Charlie', () async {
  //   await deleteAccountFromAccountManagePage(driver, 'Charlie');
  //   await driver.tap(find.byValueKey('wallet'));
  // });

  // test('create niewbie Account', () async {
  //   await addDelay(1000);
  //   await createNewbieAccount(driver, 'Li');
  //   await changeAccountFromPanel(driver, 'Tom');
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('get public key', () async {
  //   await driver.tap(find.byValueKey('profile'));
  //   await driver.waitFor(find.byValueKey('Li'));
  //   await driver.tap(find.byValueKey('Li'));
  //   await driver.waitFor(find.byValueKey('account-public-key'));
  //   await addDelay(1000);
  //   publicKey = await driver.getText(find.byValueKey('account-public-key'));
  //   await driver.tap(find.byValueKey('close-account-manage'));
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('contact-page add account Li', () async {
  //   await driver.tap(find.byValueKey('contacts'));
  //   await driver.tap(find.byValueKey('add-contact'));

  //   await driver.tap(find.byValueKey('contact-address'));
  //   await driver.enterText(publicKey);
  //   await driver.tap(find.byValueKey('contact-name'));
  //   await driver.enterText('Li');

  //   await driver.tap(find.byValueKey('contact-save'));
  // }, timeout: const Timeout(Duration(seconds: 60)));

  // test('send endorse to account from Reputable', () async {
  //   await driver.waitFor(find.byValueKey('Li'));
  //   await driver.tap(find.byValueKey('Li'));

  //   await driver.waitFor(find.byValueKey('tap-endorse-button'));
  //   await driver.tap(find.byValueKey('tap-endorse-button'));
  // }, timeout: const Timeout(Duration(seconds: 60)));

  // test('send money to account from Reputable account', () async {
  //   await driver.waitFor(find.byValueKey('send-money-to-account'));
  //   await driver.tap(find.byValueKey('send-money-to-account'));

  //   await sendMoneyToAccount(driver);
  //   await driver.takeScreenshot(Screenshots.contactsOverview);
  //   await driver.tap(find.byValueKey('wallet'));
  // });

  // test('register Tom (check status as Reputable)', () async {
  //   await scrollToCeremonyBox(driver);
  //   await registerAndWait(driver, ParticipantTypeTestHelper.reputable, shouldTakeScreenshot: true);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('Unregister [Reputable] Tom', () async {
  //   await unregisterAndWait(driver);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('Register [Reputable] Tom again', () async {
  //   await registerAndWait(driver, ParticipantTypeTestHelper.reputable);
  //   await scrollToPanelController(driver);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('register Li (check status as Endorsee)', () async {
  //   await changeAccountFromPanel(driver, 'Li');
  //   await scrollToCeremonyBox(driver);
  //   await registerAndWait(driver, ParticipantTypeTestHelper.endorsee, shouldTakeScreenshot: true);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('Unregister [Endorsee] Li', () async {
  //   await unregisterAndWait(driver);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('Register [Newbie-Endorsee] Li again', () async {
  //   await registerAndWait(driver, ParticipantTypeTestHelper.newbie);
  //   await scrollToPanelController(driver);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('account share', () async {
  //   await changeAccountFromPanel(driver, 'Tom');
  //   await shareAccount(driver, 'Tom', shouldTakeScreenshot: true);
  //   await addDelay(2500);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('account change name', () async {
  //   await accountChangeName(driver, 'Jerry', shouldTakeScreenshot: true);
  //   await addDelay(500);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('account export', () async {
  //   menemonic = await accountExport(driver, shouldTakeScreenshot: true);
  //   await addDelay(500);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('account delete from account manage page', () async {
  //   await accountDeleteFromAccountManagePage(driver);
  //   await addDelay(500);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('import account with menemonic phrase', () async {
  //   await driver.tap(find.byValueKey('wallet'));
  //   await importAccount(driver, 'Bob', menemonic, shouldTakeScreenshot: true);
  //   await addDelay(500);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('change-language-with-driver', () async {
  //   await driver.requestData(RealAppTestCommand.localeDe);
  //   await driver.takeScreenshot(Screenshots.homeLocaleDe);
  //   await driver.requestData(RealAppTestCommand.localeFr);
  //   await driver.takeScreenshot(Screenshots.homeLocaleFr);
  //   await driver.requestData(RealAppTestCommand.localeRu);
  //   await driver.takeScreenshot(Screenshots.homeLocaleRu);
  //   await driver.requestData(RealAppTestCommand.localeEn);
  //   await driver.takeScreenshot(Screenshots.homeLocaleEn);
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('change-language-from-profile-page', () async {
  //   await driver.tap(find.byValueKey('profile'));
  //   await driver.waitFor(find.byValueKey('settings-language'));
  //   await driver.tap(find.byValueKey('settings-language'));
  //   await driver.waitFor(find.text('Language'));
  //   await driver.tap(find.byValueKey('locale-de'));
  //   await driver.waitFor(find.text('Sprache'));
  //   await driver.tap(find.byValueKey('locale-fr'));
  //   await driver.waitFor(find.text('Langue'));
  //   await driver.tap(find.byValueKey('locale-ru'));
  //   await driver.waitFor(find.text('Язык'));
  //   await driver.tap(find.byValueKey('locale-en'));
  //   await driver.waitFor(find.text('Language'));
  //   await driver.tap(find.pageBack());
  // }, timeout: const Timeout(Duration(seconds: 120)));

  // test('delete all account ad show create account page', () async {
  //   await driver.waitFor(find.byValueKey('remove-all-accounts'));
  //   await rmAllAccountsFromProfilePage(driver);
  //   await addDelay(2000);
  // });

  tearDownAll(() async => driver.close());
}
