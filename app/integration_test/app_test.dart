import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/voucher/voucher_integration_test.dart';
import 'app/dev_qr_codes/dev_qr_codes_test.dart';
import 'helpers/helpers.dart';
import 'helpers/test_app_launcher.dart';
import 'app/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('EncointerWallet full integration test', (tester) async {
    final launcher = TestAppLauncher();
    await launcher.launch(tester);
    final s = launcher.appSettings;
    final b = launcher.binding;
    final l = launcher.locales;

    var publicKey = '';
    var menemonic = '';

    // create account by name Tom
    await checkAcoountEntryView(tester, b, s, l);
    await goToCreateAccountViewFromAcoountEntryView(tester);
    await createAccount(tester, b, s, l, 'Tom');

    // create PIN by text 0001
    await createPin(tester, b, s, l, EWTestKeys.testPIN);

    // close biometric auth dialog
    await tapNotNowButtonBiometricAuthEnable(tester);

    // choosing cid
    await choosingCid(tester, b, s, l, 0);

    // home-page
    await homeInit(tester, b, s, l);

    // transfer-history-empty
    await navigateToTransferHistoryPage(tester);
    await checkTransferHistoryEmpty(tester, b, s, l);

    // import account Alice
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Alice', '//Alice');
    await closePanel(tester);

    // transfer-history
    await navigateToTransferHistoryPage(tester);
    await checkTransferHistory(tester, b, s, l);

    // qr-receive page
    await goToReceiveViewFromHomeView(tester);
    await receiveView(tester, b, s, l);

    // turn on dev-mode
    await goToProfileViewFromNavBar(tester);
    await turnDevMode(tester, b, s, l);

    // change-network
    await goToNetworkView(tester);
    await changeDevNetwork(tester, 'Alice');
    await scrollToNextPhaseButton(tester);
    await takeScreenshot(b, s, Screenshots.profileDevOptions, locales: l);
    await tester.tap(find.byKey(const Key(EWTestKeys.devMode)));
    await tester.pumpAndSettle();

    // change-community
    await goToHomeViewFromNavBar(tester);
    await changeCommunity(tester);

    // Register [Bootstrapper] Alice
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.bootstrapper);

    // Unregister [Bootstrapper] Alice
    await scrollToUnregisterButton(tester);
    await unregisterAndWait(tester, b, s, l);

    // Register [Bootstrapper] Alice again
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.bootstrapper);

    // DevMode QR Voucher test: get voucher by QR, fund
    await getQrVoucherAndFund(tester, b, s, l);

    // DevMode QR Voucher test: get voucher by QR, redeem
    await getQrVoucherAndRedeem(tester);

    // finished voucher, go to HomePage
    await goToHomeViewFromNavBar(tester);

    // DevMode QR Codes tests: HomePage: save the contact from qr
    await qrFromHomeTestAndSaveContact(tester);

    // HomePage: send money with amount from qr
    await qrFromHomeTestAndSendWithAmount(tester);

    // HomePage: send money without amount from qr
    await qrFromHomeTestAndSendWithoutAmount(tester);

    // SendPage: send money with amount from qr
    await qrFromSendPageTestAndSendWithAmount(tester);

    // SendPage: send money without amount from qr
    await qrFromSendPageTestAndSendWithoutAmount(tester);

    // Check Contact Manas
    await navigateToContactsPage(tester);
    await waitForWidget(tester, find.text('Manas'));

    // ContactPage: add contact from contact-qr
    await qrFromContactAddContactFromQrContact(tester);

    // finished QR codes, go to HomePage
    await goToHomeViewFromNavBar(tester);

    // send money to Tom
    await scrollToPanelController(tester);
    await goToTransferViewFromHomeView(tester);
    await senMoneyToAccount(tester, b, s, l, 'Tom', '0.1');

    // Register [Newbie] Tom
    await changeAccountFromPanel(tester, 'Tom');
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.newbie);

    // Unregister [Newbie] Tom
    await scrollToUnregisterButton(tester);
    await unregisterAndWait(tester, b, s, l);

    // Register [Newbie] Tom again
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.newbie);
    await scrollToPanelController(tester);

    // import account Charlie
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Charlie', '//Charlie');
    await closePanel(tester);

    // import and register-Bob
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Bob', '//Bob');
    await closePanel(tester);
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.bootstrapper);
    await scrollToPanelController(tester);

    // get assigning-phase
    await goToProfileViewFromNavBar(tester);
    await getNextPhase(tester, s);

    // check assigning-phase account Assigned
    await goToHomeViewFromNavBar(tester);
    await checkAssignPhaseAssigned(tester, b, s, l);

    // check assigning-phase account Unassigned
    await scrollToPanelController(tester);
    await changeAccountFromPanel(tester, 'Charlie');
    await checkAssignPhaseUnassigned(tester, b, s, l);

    // get attesting-phase
    await scrollToPanelController(tester);
    await changeAccountFromPanel(tester, 'Bob');
    await goToProfileViewFromNavBar(tester);
    await getNextPhase(tester, s);

    // start meetup-Bob
    await goToHomeViewFromNavBar(tester);
    await scrollToStartMeetup(tester, s);
    await startMeetupTest(tester, b, s, l);
    await scrollToPanelController(tester);

    // start meetup-Tom
    await changeAccountFromPanel(tester, 'Tom');
    await scrollToStartMeetup(tester, s);
    await startMeetupTest(tester, b, s, l);
    await scrollToPanelController(tester);

    // start meetup-Alice
    await changeAccountFromPanel(tester, 'Alice');
    await scrollToStartMeetup(tester, s);
    await startMeetupTest(tester, b, s, l);
    await scrollToPanelController(tester);

    // Claim-pending (dev-mode)
    await claimPendingDev(tester, s);

    // Go to Profile Page and Check reputation count
    await goToProfileViewFromNavBar(tester);
    await checkReputationCount(tester, 2);

    // Get Registering phase
    await getNextPhase(tester, s);

    // contact-page add contact
    await goToContactViewFromNavBar(tester);
    await checkContactEmpty(tester, b, s, l);
    await addContact(tester, b, s, l, 'Obelix', '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');

    // change contact name
    await changeContactName(tester, b, s, l, 'Obelix', 'Asterix');

    // send endorse to account
    await sendEndorse(tester);

    // send money to account from Bootstrapper account
    await senMoneyToContact(tester);
    await sendMoneyToSelectedAccount(tester, b, s, l, '0.2');
    await goToHomeViewFromNavBar(tester);

    // delete account Bob
    await goToProfileViewFromNavBar(tester);
    await deleteAccountFromProfilePage(tester, 'Bob');
    await verifyInputPin(tester);

    // delete account Charlie
    await deleteAccountFromProfilePage(tester, 'Charlie');
    await verifyInputPin(tester);

    // create newbie Account
    await goToHomeViewFromNavBar(tester);
    await goToAddAcoountViewFromPanel(tester);
    await createNewbieAccount(tester, 'Li');
    await closePanel(tester);
    await changeAccountFromPanel(tester, 'Tom');

    // get public key
    await goToProfileViewFromNavBar(tester);
    publicKey = await getPublicKey(tester, 'Li');

    // contact-page add account Li
    await goToContactViewFromNavBar(tester);
    await addContact(tester, b, s, l, 'Li', publicKey);

    // send endorse to account from Reputable
    await contactDetailView(tester, 'Li');
    await sendEndorse(tester);

    // send money to account from Reputable account
    await senMoneyToContact(tester);
    await sendMoneyToSelectedAccount(tester, b, s, l, '0.2');
    await takeScreenshot(b, s, Screenshots.contactsOverview, locales: l);
    await goToHomeViewFromNavBar(tester);

    // register Tom (check status as Reputable)
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.reputable);

    // Unregister [Reputable] Tom
    await scrollToUnregisterButton(tester);
    await unregisterAndWait(tester, b, s, l);

    // Register [Reputable] Tom again
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.reputable);

    // register Li (check status as Endorsee)
    await scrollToPanelController(tester);
    await changeAccountFromPanel(tester, 'Li');
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.endorsee);

    // Unregister [Endorsee] Li
    await scrollToUnregisterButton(tester);
    await unregisterAndWait(tester, b, s, l);

    // Register [Newbie-Endorsee] Li again
    await scrollToRegisterButton(tester);
    await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.newbie);

    // account share
    await scrollToPanelController(tester);
    await changeAccountFromPanel(tester, 'Tom');
    await goToProfileViewFromNavBar(tester);
    await accountDetailPage(tester, 'Tom');
    await shareAccount(tester, b, s, l, 'Tom');

    // account change name
    await accountChangeName(tester, b, s, l, 'Jerry');

    // account export
    menemonic = await exportAccount(tester, b, s, l, EWTestKeys.testPIN);

    // account delete from account manage page
    await deleteAccountFromAccountManagePage(tester);
    await verifyInputPin(tester);

    // import account with mnemonic phrase
    await goToHomeViewFromNavBar(tester);
    await goToAddAcoountViewFromPanel(tester);
    await importAccount(tester, b, s, l, 'Bob', menemonic);

    // change-language-from-profile-page
    await goToProfileViewFromNavBar(tester);
    await changeLanguage(tester);

    // delete all accounts
    await goToProfileViewFromNavBar(tester);
    await deleteAllAccount(tester);
    await verifyInputPin(tester);
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.importAccount)));
  });
}
