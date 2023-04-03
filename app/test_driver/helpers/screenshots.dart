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
  static const importAccount002 = '002-import-account';
  static const createAccount003 = '003-create-account';
  static const pinEntry = '004-pin-entry';

  /// 21-40 home
  static const choosCommunityMap = '021-choose-community-map';
  static const homeWithRegisterButton = '022-home-with-register-button';
  static const homeRegisteredAsNewbieConformDialog = '023-home-registered-as-newbie-confirm-dialog';
  static const homeRegisteredAsNewbie = '024-home-registered-as-newbie';
  static const homeUnregisterDialog = '025-home-unregister-dialog';
  static const homeAssgningPhaseAssigned = '026-home-assgning-phase-assigned';
  static const homeAssgningPhaseUnassigned = '027-home-assigning-phase-unassigned';
  static const homeAttestingPhaseStartMeetup = '028-home-attesting-phase-start-meetup';

  /// 41-60 send and receive
  static const receiveView = '041-receive-view';
  static const sendView = '041-send-view';
  static const txConfirmationView = '042-tx-confirmation-view';

  /// 61-80 profile
  static const profileView = '061-profile-view';
  static const accountManagePage = '062-account-manage-page';
  static const accountOptionsDialog = '063-account-options-dialog';
  static const exportAccountView = '064-export-account-view';
  static const accountShareView = '065-account-share-view';

  /// 81-100 contacts
  static const contactsOverview = '081-contacts-overview';
  static const contactView = '082-contact-view';
  static const addContact = '083-add-contact';

  /// 101-120 gathering flow
  static const step1ConfirmNumberOfAttendees = '101-step-1-confirm-number-of-attendees';
  static const step2QrCode = '102-step-2-qr-code';
  static const step3FinishGathering = '103-step-3-finish-gathering';
}
