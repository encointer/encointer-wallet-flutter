import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/command/real_app_command.dart';
import 'helpers/extension/screenshot_driver_extension.dart';
import 'helpers/participant_type.dart';
import 'helpers/screenshots/screenshots.dart';
import 'real_app/real_app.dart';

void main() async {
  late FlutterDriver driver;

  var publicKey = '';
  var menemonic = '';

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
  }, timeout: const Timeout(Duration(seconds: 60)));

  test('send money to Tom', () async {
    await scrollToPanelController(driver);
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

  test('contact-page add contact', () async {
    await goToContactViewFromNavBar(driver);
    await checkContactEmpty(driver);
    await addContact(driver, 'Obelix', '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');
  });

  test('change contact name', () async {
    await changeContactName(driver, 'Obelix', 'Asterix');
  });

  test('send endorse to account', () async {
    await sendEndorse(driver);
  });

  test('send money to account from Bootstraper account', () async {
    await senMoneyToContact(driver);
    await sendMoneyToSelectedAccount(driver, '0.2');
    await goHomeViewFromNavBar(driver);
  });

  test('delete account Bob', () async {
    await goProfileViewFromNavBar(driver);
    await deleteAccountFromAccountManagePage(driver, 'Bob');
  });

  test('delete account Charlie', () async {
    await deleteAccountFromAccountManagePage(driver, 'Charlie');
  });

  test('create niewbie Account', () async {
    await goHomeViewFromNavBar(driver);
    await goToAddAcoountViewFromPanel(driver);
    await createNewbieAccount(driver, 'Li');
    await closePanel(driver);
    await changeAccountFromPanel(driver, 'Tom');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('get public key', () async {
    await goProfileViewFromNavBar(driver);
    publicKey = await getPublicKey(driver, 'Li');
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('contact-page add account Li', () async {
    await goToContactViewFromNavBar(driver);
    await addContact(driver, 'Li', publicKey);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('send endorse to account from Reputable', () async {
    await contactDetailView(driver, 'Li');
    await sendEndorse(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('send money to account from Reputable account', () async {
    await senMoneyToContact(driver);
    await sendMoneyToSelectedAccount(driver, '0.2');
    await driver.takeScreenshot(Screenshots.contactsOverview);
    await goHomeViewFromNavBar(driver);
  });

  test('register Tom (check status as Reputable)', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.reputable, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Unregister [Reputable] Tom', () async {
    await unregisterAndWait(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Register [Reputable] Tom again', () async {
    await registerAndWait(driver, ParticipantTypeTestHelper.reputable);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('register Li (check status as Endorsee)', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Li');
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.endorsee, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Unregister [Endorsee] Li', () async {
    await unregisterAndWait(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('Register [Newbie-Endorsee] Li again', () async {
    await registerAndWait(driver, ParticipantTypeTestHelper.newbie);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account share', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Tom');
    await goProfileViewFromNavBar(driver);
    await shareAccount(driver, 'Tom', shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account change name', () async {
    await accountChangeName(driver, 'Jerry', shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account export', () async {
    menemonic = await exportAcoount(driver, '0001', shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('account delete from account manage page', () async {
    await accountDeleteFromAccountManagePage(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('import account with menemonic phrase', () async {
    await goHomeViewFromNavBar(driver);
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Bob', menemonic, shouldTakeScreenshot: true);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('change-language-from-profile-page', () async {
    await goProfileViewFromNavBar(driver);
    await changeLanguage(driver);
  }, timeout: const Timeout(Duration(seconds: 120)));

  test('delete all account ad show create account page', () async {
    await deleteAllAccount(driver);
  });

  tearDownAll(() async => driver.close());
}
