import 'dart:developer';
import 'dart:io';

import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

class Screenshots {
  /// 0-20 onboarding stuff
  static const accountEntryView = '001-account-entry-view';
  static const createAccount = '002-create-account';
  static const pinEntry = '003-pin-entry';
  static const importAccount = '004-import-account';

  /// 21-40 home
  static const chooseCommunityMap = '021-choose-community-map';
  static const homeWithRegisterButton = '022-home-with-register-button';
  static const homeRegisteredAsNewbieConfirmDialog = '023-home-registered-as-newbie-confirm-dialog';
  static const homeRegisteredAsNewbie = '024-home-registered-as-newbie';
  static const homeRegisteredAsBootstrapperConfirmDialog = '025-home-registered-as-bootstrapper-confirm-dialog';
  static const homeRegisteredAsBootstrapper = '026-home-registered-as-bootstrapper';
  static const homeRegisteredAsReputableConfirmDialog = '027-home-registered-as-reputable-confirm-dialog';
  static const homeRegisteredAsReputable = '028-home-registered-as-reputable';
  static const homeRegisteredAsEndorseeConfirmDialog = '029-home-registered-as-endorsee-confirm-dialog';
  static const homeRegisteredAsEndorsee = '030-home-registered-as-endorsee';
  static const homeUnregisterDialog = '031-home-unregister-dialog';
  static const homeAssigningPhaseAssigned = '032-home-assigning-phase-assigned';
  static const homeAssigningPhaseUnassigned = '033-home-assigning-phase-unassigned';
  static const homeAttestingPhaseStartMeetup = '034-home-attesting-phase-start-meetup';

  /// 41-60 send and receive
  static const receiveView = '041-receive-view';
  static const sendView = '042-send-view';
  static const txConfirmationView = '043-tx-confirmation-view';
  static const voucherDialog = '044-reap-voucher-dialog';
  static const txHistoryEmpty = '045-tx-history-empty';
  static const txHistory = '046-tx-history';

  /// 61-80 profile
  static const profileView = '061-profile-view';
  static const accountManageView = '062-account-manage-view';
  static const changeAccountName = '063-change-account-name';
  static const accountOptionsDialog = '064-account-options-dialog';
  static const accountPasswordDialog = '065-account-password-dialog';
  static const exportAccountView = '066-export-account-view';
  static const accountShareView = '067-account-share-view';
  static const profileDevOptions = '068-profile-dev-options';

  /// 81-100 contacts
  static const contactsOverviewEmpty = '081-contacts-overview-empty';
  static const addContact = '082-add-contact';
  static const contactView = '083-contact-view';
  static const changeContactName = '084-change-contact-name';
  static const contactsOverview = '085-contacts-overview';

  /// 101-120 gathering flow
  static const step1ConfirmNumberOfAttendees = '101-step-1-confirm-number-of-attendees';
  static const step2QrCode = '102-step-2-qr-code';
  static const step3FinishGathering = '103-step-3-finish-gathering';
}

/// Takes a screenshot on Android when locale-based captures are enabled.
///
/// Mirrors the old [ScreenshotExtension.takeLocalScreenshot] behavior:
/// turns dev mode off, iterates over each requested locale, captures one
/// PNG per locale.
Future<void> takeScreenshot(
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  String name, {
  List<String> locales = const [],
  String directory = '../screenshots',
}) async {
  if (!Platform.isAndroid) return;
  if (!locales.contains('en')) return;
  if (File('$directory/en/$name.png').existsSync()) return;

  // Turn off dev mode for clean screenshots, matching old behavior.
  if (appSettings.developerMode) appSettings.toggleDeveloperMode();

  for (final locale in locales) {
    if (appSettings.locale.languageCode != locale) {
      await appSettings.setLocale(locale);
    }
    final currentLocale = appSettings.locale.languageCode;
    try {
      final pixels = await binding.takeScreenshot(name);
      final directoryPath = '$directory/$currentLocale';
      final file = await File('$directoryPath/$name.png').create(recursive: true);
      await file.writeAsBytes(pixels);
      // ignore: avoid_print
      print('Screenshot $name created at ${file.path}');
    } catch (e) {
      log('Failed to take screenshot $name for locale $currentLocale: $e');
    }
  }
}
