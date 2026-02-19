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

    try {
      // create account by name Tom
      debugPrint('STEP 01: checkAccountEntryView');
      await checkAcoountEntryView(tester, b, s, l);
      debugPrint('STEP 02: goToCreateAccountView');
      await goToCreateAccountViewFromAcoountEntryView(tester);
      debugPrint('STEP 03: createAccount Tom');
      await createAccount(tester, b, s, l, 'Tom');

      // create PIN by text 0001
      debugPrint('STEP 04: createPin');
      await createPin(tester, b, s, l, EWTestKeys.testPIN);

      // close biometric auth dialog
      debugPrint('STEP 05: tapNotNowButtonBiometricAuthEnable');
      await tapNotNowButtonBiometricAuthEnable(tester);

      // choosing cid
      debugPrint('STEP 06: choosingCid');
      await choosingCid(tester, b, s, l, 0);

      // home-page
      debugPrint('STEP 07: homeInit');
      await homeInit(tester, b, s, l);

      // transfer-history-empty
      debugPrint('STEP 08: navigateToTransferHistoryPage');
      await navigateToTransferHistoryPage(tester);
      debugPrint('STEP 09: checkTransferHistoryEmpty');
      await checkTransferHistoryEmpty(tester, b, s, l);

      // import account Alice
      debugPrint('STEP 10: goToAddAccountViewFromPanel');
      await goToAddAcoountViewFromPanel(tester);
      debugPrint('STEP 11: importAccount Alice');
      await importAccount(tester, b, s, l, 'Alice', '//Alice');
      debugPrint('STEP 12: closePanel');
      await closePanel(tester);

      // transfer-history
      debugPrint('STEP 13: navigateToTransferHistoryPage');
      await navigateToTransferHistoryPage(tester);
      debugPrint('STEP 14: checkTransferHistory');
      await checkTransferHistory(tester, b, s, l);

      // qr-receive page
      debugPrint('STEP 15: goToReceiveViewFromHomeView');
      await goToReceiveViewFromHomeView(tester);
      debugPrint('STEP 16: receiveView');
      await receiveView(tester, b, s, l);

      // turn on dev-mode
      debugPrint('STEP 17: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 18: turnDevMode');
      await turnDevMode(tester, b, s, l);

      // change-network
      debugPrint('STEP 19: goToNetworkView');
      await goToNetworkView(tester);
      debugPrint('STEP 20: changeDevNetwork Alice');
      await changeDevNetwork(tester, 'Alice');
      debugPrint('STEP 21: scrollToNextPhaseButton');
      await scrollToNextPhaseButton(tester);
      await takeScreenshot(b, s, Screenshots.profileDevOptions, locales: l);
      debugPrint('STEP 22: tap devMode toggle off');
      await tester.tap(find.byKey(const Key(EWTestKeys.devMode)));
      await tester.pumpAndSettle();

      // change-community
      debugPrint('STEP 23: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);
      debugPrint('STEP 24: changeCommunity');
      await changeCommunity(tester);

      // Register [Bootstrapper] Alice
      debugPrint('STEP 25: scrollToRegisterButton (Alice Bootstrapper)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 26: registerAndWait (Alice Bootstrapper)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.bootstrapper);

      // Unregister [Bootstrapper] Alice
      debugPrint('STEP 27: scrollToUnregisterButton (Alice)');
      await scrollToUnregisterButton(tester);
      debugPrint('STEP 28: unregisterAndWait (Alice)');
      await unregisterAndWait(tester, b, s, l);

      // Register [Bootstrapper] Alice again
      debugPrint('STEP 29: scrollToRegisterButton (Alice Bootstrapper again)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 30: registerAndWait (Alice Bootstrapper again)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.bootstrapper);

      // DevMode QR Voucher test: get voucher by QR, fund
      debugPrint('STEP 31: getQrVoucherAndFund');
      await getQrVoucherAndFund(tester, b, s, l);

      // DevMode QR Voucher test: get voucher by QR, redeem
      debugPrint('STEP 32: getQrVoucherAndRedeem');
      await getQrVoucherAndRedeem(tester);

      // finished voucher, go to HomePage
      debugPrint('STEP 33: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);

      // DevMode QR Codes tests: HomePage: save the contact from qr
      debugPrint('STEP 34: qrFromHomeTestAndSaveContact');
      await qrFromHomeTestAndSaveContact(tester);

      // HomePage: send money with amount from qr
      debugPrint('STEP 35: qrFromHomeTestAndSendWithAmount');
      await qrFromHomeTestAndSendWithAmount(tester);

      // HomePage: send money without amount from qr
      debugPrint('STEP 36: qrFromHomeTestAndSendWithoutAmount');
      await qrFromHomeTestAndSendWithoutAmount(tester);

      // SendPage: send money with amount from qr
      debugPrint('STEP 37: qrFromSendPageTestAndSendWithAmount');
      await qrFromSendPageTestAndSendWithAmount(tester);

      // SendPage: send money without amount from qr
      debugPrint('STEP 38: qrFromSendPageTestAndSendWithoutAmount');
      await qrFromSendPageTestAndSendWithoutAmount(tester);

      // Check Contact Manas
      debugPrint('STEP 39: navigateToContactsPage');
      await navigateToContactsPage(tester);
      debugPrint('STEP 40: waitForWidget Manas');
      await waitForWidget(tester, find.text('Manas'));

      // ContactPage: add contact from contact-qr
      debugPrint('STEP 41: qrFromContactAddContactFromQrContact');
      await qrFromContactAddContactFromQrContact(tester);

      // finished QR codes, go to HomePage
      debugPrint('STEP 42: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);

      // send money to Tom
      debugPrint('STEP 43: scrollToPanelController');
      await scrollToPanelController(tester);
      debugPrint('STEP 44: goToTransferViewFromHomeView');
      await goToTransferViewFromHomeView(tester);
      debugPrint('STEP 45: sendMoneyToAccount Tom 0.1');
      await senMoneyToAccount(tester, b, s, l, 'Tom', '0.1');

      // Register [Newbie] Tom
      debugPrint('STEP 46: changeAccountFromPanel Tom');
      await changeAccountFromPanel(tester, 'Tom');
      debugPrint('STEP 47: scrollToRegisterButton (Tom Newbie)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 48: registerAndWait (Tom Newbie)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.newbie);

      // Unregister [Newbie] Tom
      debugPrint('STEP 49: scrollToUnregisterButton (Tom)');
      await scrollToUnregisterButton(tester);
      debugPrint('STEP 50: unregisterAndWait (Tom)');
      await unregisterAndWait(tester, b, s, l);

      // Register [Newbie] Tom again
      debugPrint('STEP 51: scrollToRegisterButton (Tom Newbie again)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 52: registerAndWait (Tom Newbie again)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.newbie);
      debugPrint('STEP 53: scrollToPanelController');
      await scrollToPanelController(tester);

      // import account Charlie
      debugPrint('STEP 54: goToAddAccountViewFromPanel (Charlie)');
      await goToAddAcoountViewFromPanel(tester);
      debugPrint('STEP 55: importAccount Charlie');
      await importAccount(tester, b, s, l, 'Charlie', '//Charlie');
      debugPrint('STEP 56: closePanel');
      await closePanel(tester);

      // import and register-Bob
      debugPrint('STEP 57: goToAddAccountViewFromPanel (Bob)');
      await goToAddAcoountViewFromPanel(tester);
      debugPrint('STEP 58: importAccount Bob');
      await importAccount(tester, b, s, l, 'Bob', '//Bob');
      debugPrint('STEP 59: closePanel');
      await closePanel(tester);
      debugPrint('STEP 60: scrollToRegisterButton (Bob Bootstrapper)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 61: registerAndWait (Bob Bootstrapper)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.bootstrapper);
      debugPrint('STEP 62: scrollToPanelController');
      await scrollToPanelController(tester);

      // get assigning-phase
      debugPrint('STEP 63: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 64: getNextPhase (assigning)');
      await getNextPhase(tester, s);

      // check assigning-phase account Assigned
      debugPrint('STEP 65: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);
      debugPrint('STEP 66: checkAssignPhaseAssigned');
      await checkAssignPhaseAssigned(tester, b, s, l);

      // check assigning-phase account Unassigned
      debugPrint('STEP 67: scrollToPanelController');
      await scrollToPanelController(tester);
      debugPrint('STEP 68: changeAccountFromPanel Charlie');
      await changeAccountFromPanel(tester, 'Charlie');
      debugPrint('STEP 69: checkAssignPhaseUnassigned');
      await checkAssignPhaseUnassigned(tester, b, s, l);

      // get attesting-phase
      debugPrint('STEP 70: scrollToPanelController');
      await scrollToPanelController(tester);
      debugPrint('STEP 71: changeAccountFromPanel Bob');
      await changeAccountFromPanel(tester, 'Bob');
      debugPrint('STEP 72: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 73: getNextPhase (attesting)');
      await getNextPhase(tester, s);

      // start meetup-Bob
      debugPrint('STEP 74: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);
      debugPrint('STEP 75: scrollToStartMeetup (Bob)');
      await scrollToStartMeetup(tester, s);
      debugPrint('STEP 76: startMeetupTest (Bob)');
      await startMeetupTest(tester, b, s, l);
      debugPrint('STEP 77: scrollToPanelController');
      await scrollToPanelController(tester);

      // start meetup-Tom
      debugPrint('STEP 78: changeAccountFromPanel Tom');
      await changeAccountFromPanel(tester, 'Tom');
      debugPrint('STEP 79: scrollToStartMeetup (Tom)');
      await scrollToStartMeetup(tester, s);
      debugPrint('STEP 80: startMeetupTest (Tom)');
      await startMeetupTest(tester, b, s, l);
      debugPrint('STEP 81: scrollToPanelController');
      await scrollToPanelController(tester);

      // start meetup-Alice
      debugPrint('STEP 82: changeAccountFromPanel Alice');
      await changeAccountFromPanel(tester, 'Alice');
      debugPrint('STEP 83: scrollToStartMeetup (Alice)');
      await scrollToStartMeetup(tester, s);
      debugPrint('STEP 84: startMeetupTest (Alice)');
      await startMeetupTest(tester, b, s, l);
      debugPrint('STEP 85: scrollToPanelController');
      await scrollToPanelController(tester);

      // Claim-pending (dev-mode)
      debugPrint('STEP 86: claimPendingDev');
      await claimPendingDev(tester, s);

      // Go to Profile Page and Check reputation count
      debugPrint('STEP 87: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 88: checkReputationCount');
      await checkReputationCount(tester, 2);

      // Get Registering phase
      debugPrint('STEP 89: getNextPhase (registering)');
      await getNextPhase(tester, s);

      // contact-page add contact
      debugPrint('STEP 90: goToContactViewFromNavBar');
      await goToContactViewFromNavBar(tester);
      debugPrint('STEP 91: checkContactEmpty');
      await checkContactEmpty(tester, b, s, l);
      debugPrint('STEP 92: addContact Obelix');
      await addContact(tester, b, s, l, 'Obelix', '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW');

      // change contact name
      debugPrint('STEP 93: changeContactName Obelix->Asterix');
      await changeContactName(tester, b, s, l, 'Obelix', 'Asterix');

      // send endorse to account
      debugPrint('STEP 94: sendEndorse');
      await sendEndorse(tester);

      // send money to account from Bootstrapper account
      debugPrint('STEP 95: sendMoneyToContact');
      await senMoneyToContact(tester);
      debugPrint('STEP 96: sendMoneyToSelectedAccount 0.2');
      await sendMoneyToSelectedAccount(tester, b, s, l, '0.2');
      debugPrint('STEP 97: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);

      // delete account Bob
      debugPrint('STEP 98: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 99: deleteAccountFromProfilePage Bob');
      await deleteAccountFromProfilePage(tester, 'Bob');
      debugPrint('STEP 100: verifyInputPin');
      await verifyInputPin(tester);

      // delete account Charlie
      debugPrint('STEP 101: deleteAccountFromProfilePage Charlie');
      await deleteAccountFromProfilePage(tester, 'Charlie');
      debugPrint('STEP 102: verifyInputPin');
      await verifyInputPin(tester);

      // create newbie Account
      debugPrint('STEP 103: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);
      debugPrint('STEP 104: goToAddAccountViewFromPanel (Li)');
      await goToAddAcoountViewFromPanel(tester);
      debugPrint('STEP 105: createNewbieAccount Li');
      await createNewbieAccount(tester, 'Li');
      debugPrint('STEP 106: closePanel');
      await closePanel(tester);
      debugPrint('STEP 107: changeAccountFromPanel Tom');
      await changeAccountFromPanel(tester, 'Tom');

      // get public key
      debugPrint('STEP 108: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 109: getPublicKey Li');
      publicKey = await getPublicKey(tester, 'Li');

      // contact-page add account Li
      debugPrint('STEP 110: goToContactViewFromNavBar');
      await goToContactViewFromNavBar(tester);
      debugPrint('STEP 111: addContact Li');
      await addContact(tester, b, s, l, 'Li', publicKey);

      // send endorse to account from Reputable
      debugPrint('STEP 112: contactDetailView Li');
      await contactDetailView(tester, 'Li');
      debugPrint('STEP 113: sendEndorse (Reputable)');
      await sendEndorse(tester);

      // send money to account from Reputable account
      debugPrint('STEP 114: sendMoneyToContact');
      await senMoneyToContact(tester);
      debugPrint('STEP 115: sendMoneyToSelectedAccount 0.2');
      await sendMoneyToSelectedAccount(tester, b, s, l, '0.2');
      await takeScreenshot(b, s, Screenshots.contactsOverview, locales: l);
      debugPrint('STEP 116: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);

      // register Tom (check status as Reputable)
      debugPrint('STEP 117: scrollToRegisterButton (Tom Reputable)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 118: registerAndWait (Tom Reputable)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.reputable);

      // Unregister [Reputable] Tom
      debugPrint('STEP 119: scrollToUnregisterButton (Tom)');
      await scrollToUnregisterButton(tester);
      debugPrint('STEP 120: unregisterAndWait (Tom)');
      await unregisterAndWait(tester, b, s, l);

      // Register [Reputable] Tom again
      debugPrint('STEP 121: scrollToRegisterButton (Tom Reputable again)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 122: registerAndWait (Tom Reputable again)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.reputable);

      // register Li (check status as Endorsee)
      debugPrint('STEP 123: scrollToPanelController');
      await scrollToPanelController(tester);
      debugPrint('STEP 124: changeAccountFromPanel Li');
      await changeAccountFromPanel(tester, 'Li');
      debugPrint('STEP 125: scrollToRegisterButton (Li Endorsee)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 126: registerAndWait (Li Endorsee)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.endorsee);

      // Unregister [Endorsee] Li
      debugPrint('STEP 127: scrollToUnregisterButton (Li)');
      await scrollToUnregisterButton(tester);
      debugPrint('STEP 128: unregisterAndWait (Li)');
      await unregisterAndWait(tester, b, s, l);

      // Register [Newbie-Endorsee] Li again
      debugPrint('STEP 129: scrollToRegisterButton (Li Newbie)');
      await scrollToRegisterButton(tester);
      debugPrint('STEP 130: registerAndWait (Li Newbie)');
      await registerAndWait(tester, b, s, l, ParticipantTypeTestHelper.newbie);

      // account share
      debugPrint('STEP 131: scrollToPanelController');
      await scrollToPanelController(tester);
      debugPrint('STEP 132: changeAccountFromPanel Tom');
      await changeAccountFromPanel(tester, 'Tom');
      debugPrint('STEP 133: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 134: accountDetailPage Tom');
      await accountDetailPage(tester, 'Tom');
      debugPrint('STEP 135: shareAccount Tom');
      await shareAccount(tester, b, s, l, 'Tom');

      // account change name
      debugPrint('STEP 136: accountChangeName Jerry');
      await accountChangeName(tester, b, s, l, 'Jerry');

      // account export
      debugPrint('STEP 137: exportAccount');
      menemonic = await exportAccount(tester, b, s, l, EWTestKeys.testPIN);

      // account delete from account manage page
      debugPrint('STEP 138: deleteAccountFromAccountManagePage');
      await deleteAccountFromAccountManagePage(tester);
      debugPrint('STEP 139: verifyInputPin');
      await verifyInputPin(tester);

      // import account with mnemonic phrase
      debugPrint('STEP 140: goToHomeViewFromNavBar');
      await goToHomeViewFromNavBar(tester);
      debugPrint('STEP 141: goToAddAccountViewFromPanel');
      await goToAddAcoountViewFromPanel(tester);
      debugPrint('STEP 142: importAccount Bob (mnemonic)');
      await importAccount(tester, b, s, l, 'Bob', menemonic);

      // change-language-from-profile-page
      debugPrint('STEP 143: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 144: changeLanguage');
      await changeLanguage(tester);

      // delete all accounts
      debugPrint('STEP 145: goToProfileViewFromNavBar');
      await goToProfileViewFromNavBar(tester);
      debugPrint('STEP 146: deleteAllAccount');
      await deleteAllAccount(tester);
      debugPrint('STEP 147: verifyInputPin');
      await verifyInputPin(tester);
      debugPrint('STEP 148: waitForWidget importAccount');
      await waitForWidget(tester, find.byKey(const Key(EWTestKeys.importAccount)));

      debugPrint('ALL STEPS COMPLETED');
    } catch (e, stack) {
      debugPrint('TEST FAILED: $e');
      debugPrint('FULL STACK TRACE:\n$stack');
      rethrow;
    }
  });
}
