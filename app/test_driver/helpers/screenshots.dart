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
  static const onboard001 = '001-onboarding';
  static const createAccount = '002-create-account';
  static const pinEntry = '003-pin-entry';
  static const importAccount = '004-import-account';

  /// 21-40 home
  static const choosCommunityMap = '021-choose-community-map';
  static const homeWithRegisterButton = '022-home-with-register-button';
  static const homeRegisteredAsNewbieConformDialog = '023-home-registered-as-newbie-confirm-dialog';
  static const homeRegisteredAsNewbie = '024-home-registered-as-newbie';
  static const homeUnregisterDialog = '025-home-unregister-dialog';
  static const homeAssigningPhaseAssigned = '026-home-assigning-phase-assigned';
  static const homeAssigningPhaseUnassigned = '027-home-assigning-phase-unassigned';
  static const homeAttestingPhaseStartMeetup = '028-home-attesting-phase-start-meetup';

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
  static const contactsOverview = '081-contacts-overview';
  static const addContact = '082-add-contact';
  static const contactView = '083-contact-view';
  static const changeContactName = '084-change-contact-name';

  /// 101-120 gathering flow
  static const step1ConfirmNumberOfAttendees = '101-step-1-confirm-number-of-attendees';
  static const step2QrCode = '102-step-2-qr-code';
  static const step3FinishGathering = '103-step-3-finish-gathering';
}
