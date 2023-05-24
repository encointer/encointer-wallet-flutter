import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/helper.dart';
import 'real_app/real_app.dart';

void main() async {
  late FlutterDriver driver;
  const timeout120 = Timeout(Duration(seconds: 120));

  var publicKey = '';
  var menemonic = '';

  group('EncointerWallet App', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      final locales = await driver.requestData(RealAppTestCommand.locales);
      driver.locales = locales.split(',');
      await driver.waitUntilFirstFrameRasterized();
    });
  });

  test('create account by name Tom', () async {
    await checkAcoountEntryView(driver);
    await goToCreateAccountViewFromAcoountEntryView(driver);
    await createAccount(driver, 'Tom');
  }, timeout: timeout120);

  test('create PIN by text 0001', () async {
    await createPin(driver, '0001');
  }, timeout: timeout120);

  test('choosing cid', () async {
    await choosingCid(driver, 0);
  }, timeout: timeout120);

  test('home-page', () async {
    await homeInit(driver);
  }, timeout: timeout120);

  test('qr-receive page', () async {
    await goToReceiveViewFromHomeView(driver);
    await receiveView(driver);
  }, timeout: timeout120);

  test('turn on dev-mode', () async {
    await goToProfileViewFromNavBar(driver);
    await turnDevMode(driver);
  }, timeout: timeout120);

  test('change-network', () async {
    await goToNetworkView(driver);
    await changeDevNetwork(driver, 'Tom');
  }, timeout: timeout120);

  test('change-community', () async {
    await goToHomeViewFromNavBar(driver);
    await changeCommunity(driver);
  }, timeout: timeout120);

  test('import account Alice', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Alice', '//Alice');
    await closePanel(driver);
  }, timeout: timeout120);

  test('Register [Bootstrapper] Alice', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
  }, timeout: timeout120);

  test('Unregister [Bootstrapper] Alice', () async {
    await scrollToCeremonyBox(driver);
    await unregisterAndWait(driver);
  }, timeout: timeout120);

  test('Register [Bootstrapper] Alice again', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
  }, timeout: timeout120);

  test('send money to Tom', () async {
    await scrollToPanelController(driver);
    await goToTransferViewFromHomeView(driver);
    await senMoneyToAccount(driver, 'Tom', '0.1');
  }, timeout: timeout120);

  test('Register [Newbie] Tom', () async {
    await changeAccountFromPanel(driver, 'Tom');
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.newbie);
  }, timeout: timeout120);

  test('Unregister [Newbie] Tom', () async {
    await scrollToCeremonyBox(driver);
    await unregisterAndWait(driver);
  }, timeout: timeout120);

  test('Register [Newbie] Tom again', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.newbie);
    await scrollToPanelController(driver);
  }, timeout: timeout120);

  test('import account Charlie', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Charlie', '//Charlie');
    await closePanel(driver);
  }, timeout: timeout120);

  test('import and register-Bob', () async {
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Bob', '//Bob');
    await closePanel(driver);
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.bootstrapper);
    await scrollToPanelController(driver);
  }, timeout: timeout120);

  test('get assignin-phase', () async {
    await goToProfileViewFromNavBar(driver);
    await getNextPhase(driver);
  }, timeout: timeout120);

  test('check assignin-phase account Assigned', () async {
    await goToHomeViewFromNavBar(driver);
    await checkAssignPhaseAssigned(driver);
  }, timeout: timeout120);

  test('check assignin-phase account Unassigned', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Charlie');
    await checkAssignPhaseUnassigned(driver);
  }, timeout: timeout120);

  test('get attesting-phase', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Bob');
    await goToProfileViewFromNavBar(driver);
    await getNextPhase(driver);
  }, timeout: timeout120);

  test('start meetup-Bob', () async {
    await goToHomeViewFromNavBar(driver);
    await scrollToStartMeetup(driver);
    await startMeetupTest(driver);
    await scrollToPanelController(driver);
  }, timeout: timeout120);

  test('start meetup-Tom', () async {
    await changeAccountFromPanel(driver, 'Tom');
    await scrollToStartMeetup(driver);
    await startMeetupTest(driver);
    await scrollToPanelController(driver);
  }, timeout: timeout120);

  test('start meetup-Alice', () async {
    await changeAccountFromPanel(driver, 'Alice');
    await scrollToStartMeetup(driver);
    await startMeetupTest(driver);
    await scrollToPanelController(driver);
  }, timeout: timeout120);

  test('Claim-pending (dev-mode)', () async {
    await claimPendingDev(driver);
  }, timeout: timeout120);

  test('Go to Profile Page and Check reputation count', () async {
    await goToProfileViewFromNavBar(driver);
    await checkPeputationCount(driver, 2);
  }, timeout: timeout120);

  test('Get Registering phase', () async {
    await getNextPhase(driver);
  }, timeout: timeout120);

  test('contact-page add contact', () async {
    await goToContactViewFromNavBar(driver);
    await checkContactEmpty(driver);
    await addContact(driver, 'Obelix', '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');
  }, timeout: timeout120);

  test('change contact name', () async {
    await changeContactName(driver, 'Obelix', 'Asterix');
  }, timeout: timeout120);

  test('send endorse to account', () async {
    await sendEndorse(driver);
  }, timeout: timeout120);

  test('send money to account from Bootstraper account', () async {
    await senMoneyToContact(driver);
    await sendMoneyToSelectedAccount(driver, '0.2');
    await goToHomeViewFromNavBar(driver);
  }, timeout: timeout120);

  test('delete account Bob', () async {
    await goToProfileViewFromNavBar(driver);
    await deleteAccountFromProfilePage(driver, 'Bob');
  }, timeout: timeout120);

  test('delete account Charlie', () async {
    await deleteAccountFromProfilePage(driver, 'Charlie');
  }, timeout: timeout120);

  test('create niewbie Account', () async {
    await goToHomeViewFromNavBar(driver);
    await goToAddAcoountViewFromPanel(driver);
    await createNewbieAccount(driver, 'Li');
    await closePanel(driver);
    await changeAccountFromPanel(driver, 'Tom');
  }, timeout: timeout120);

  test('get public key', () async {
    await goToProfileViewFromNavBar(driver);
    publicKey = await getPublicKey(driver, 'Li');
  }, timeout: timeout120);

  test('contact-page add account Li', () async {
    await goToContactViewFromNavBar(driver);
    await addContact(driver, 'Li', publicKey);
  }, timeout: timeout120);

  test('send endorse to account from Reputable', () async {
    await contactDetailView(driver, 'Li');
    await sendEndorse(driver);
  }, timeout: timeout120);

  test('send money to account from Reputable account', () async {
    await senMoneyToContact(driver);
    await sendMoneyToSelectedAccount(driver, '0.2');
    await driver.takeLocalScreenshot(Screenshots.contactsOverview);
    await goToHomeViewFromNavBar(driver);
  }, timeout: timeout120);

  test('register Tom (check status as Reputable)', () async {
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.reputable);
  }, timeout: timeout120);

  test('Unregister [Reputable] Tom', () async {
    await unregisterAndWait(driver);
  }, timeout: timeout120);

  test('Register [Reputable] Tom again', () async {
    await registerAndWait(driver, ParticipantTypeTestHelper.reputable);
  }, timeout: timeout120);

  test('register Li (check status as Endorsee)', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Li');
    await scrollToCeremonyBox(driver);
    await registerAndWait(driver, ParticipantTypeTestHelper.endorsee);
  }, timeout: timeout120);

  test('Unregister [Endorsee] Li', () async {
    await unregisterAndWait(driver);
  }, timeout: timeout120);

  test('Register [Newbie-Endorsee] Li again', () async {
    await registerAndWait(driver, ParticipantTypeTestHelper.newbie);
  }, timeout: timeout120);

  test('account share', () async {
    await scrollToPanelController(driver);
    await changeAccountFromPanel(driver, 'Tom');
    await goToProfileViewFromNavBar(driver);
    await accountDetailPage(driver, 'Tom');
    await shareAccount(driver, 'Tom');
  }, timeout: timeout120);

  test('account change name', () async {
    await accountChangeName(driver, 'Jerry');
  }, timeout: timeout120);

  test('account export', () async {
    menemonic = await exportAccount(driver, '0001');
  }, timeout: timeout120);

  test('account delete from account manage page', () async {
    await deleteAccountFromAccountManagePage(driver);
  }, timeout: timeout120);

  test('import account with menemonic phrase', () async {
    await goToHomeViewFromNavBar(driver);
    await goToAddAcoountViewFromPanel(driver);
    await importAccount(driver, 'Bob', menemonic);
  }, timeout: timeout120);

  test('change-language-from-profile-page', () async {
    await goToProfileViewFromNavBar(driver);
    await changeLanguage(driver);
  }, timeout: timeout120);

  test('delete all accounts', () async {
    await deleteAllAccount(driver);
  }, timeout: timeout120);

  tearDownAll(() async => driver.close());
}
