import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

Future<void> takeScreenshot(
  FlutterDriver driver,
  String name, {
  String directory = '../screenshots',
  Duration timeout = const Duration(seconds: 30),
  bool waitUntilNoTransientCallbacks = true,
}) async {
  if (waitUntilNoTransientCallbacks) {
    await driver.waitUntilNoTransientCallbacks(timeout: timeout);
  }

  final pixels = await driver.screenshot();
  final directoryPath = directory.endsWith('/') ? directory : '$directory/';
  final file = await File('$directoryPath$name.png').create(recursive: true);
  await file.writeAsBytes(pixels);
  // ignore: avoid_print
  print('Screenshot $name created at ${file.path}');
}

class Screenshots {
  /// 0-20 onboarding stuff
  static const splashView = '001-splash-view';
  static const accountEntryView = '002-account-entry-view';
  static const createAccount = '003-create-account';
  static const pinEntry = '004-pin-entry';
  static const importAccount = '005-import-account';

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

  /// 61-80 profile
  static const profileView = '061-profile-view';
  static const accountManageView = '062-account-manage-view';
  static const changeAccountName = '063-change-account-name';
  static const accountOptionsDialog = '064-account-options-dialog';
  static const accountPasswordDialog = '065-account-password-dialog';
  static const exportAccountView = '066-export-account-view';
  static const accountShareView = '067-account-share-view';

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

enum ParticipantTypeTest {
  newbie(
    'Newbie',
    educationDialogScreenshot: Screenshots.homeRegisteredAsNewbieConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsNewbie,
  ),
  bootstrapper(
    'Bootstrapper',
    educationDialogScreenshot: Screenshots.homeRegisteredAsNewbieConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsNewbie,
  ),
  reputable(
    'Reputable',
    educationDialogScreenshot: Screenshots.homeRegisteredAsNewbieConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsNewbie,
  ),
  endorsee(
    'Endorsee',
    educationDialogScreenshot: Screenshots.homeRegisteredAsNewbieConfirmDialog,
    registeredAsType: Screenshots.homeRegisteredAsNewbie,
  );

  const ParticipantTypeTest(
    this.type, {
    required this.educationDialogScreenshot,
    required this.registeredAsType,
  });

  final String type;
  final String educationDialogScreenshot;
  final String registeredAsType;
}
