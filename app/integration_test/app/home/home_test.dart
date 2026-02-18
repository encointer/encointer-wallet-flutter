import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/helpers.dart';
import 'home_helper.dart';

Future<void> homeInit(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await refreshWalletPage(tester);
  await takeScreenshot(binding, appSettings, Screenshots.homeWithRegisterButton, locales: locales);
}

Future<void> changeCommunity(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.panelController)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(EWTestKeys.addCommunity)));
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(Key(EWTestKeys.cidMarkerIcon(0))));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(EWTestKeys.cidMarkerDescription(0))));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.addCommunity)));

  await Future<void>.delayed(const Duration(milliseconds: 1000));
  await closePanel(tester);
  await refreshWalletPage(tester);
}

Future<void> registerAndWait(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  ParticipantTypeTestHelper registrationType,
) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.registrationMeetupButton)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(Key(EWTestKeys.educateDialogRegistrationType(registrationType.type))));
  await takeScreenshot(binding, appSettings, registrationType.educationDialogScreenshotName, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.closeEducateDialog)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.isRegisteredInfo)));
  await takeScreenshot(binding, appSettings, registrationType.screenshotName, locales: locales);
}

Future<void> unregisterAndWait(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.unregisterButton)));
  await tester.tap(find.byKey(const Key(EWTestKeys.unregisterButton)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.unregisterDialog)));
  await takeScreenshot(binding, appSettings, Screenshots.homeUnregisterDialog, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.okButton)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.registrationMeetupButton)));
}

Future<void> checkAssignPhaseAssigned(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.listViewWallet)));
  await scrollToCeremonyBox(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountAssigned)));
  await takeScreenshot(binding, appSettings, Screenshots.homeAssigningPhaseAssigned, locales: locales);
}

Future<void> checkAssignPhaseUnassigned(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await scrollToCeremonyBox(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountUnassigned)));
  await takeScreenshot(binding, appSettings, Screenshots.homeAssigningPhaseUnassigned, locales: locales);
}

Future<void> claimPendingDev(WidgetTester tester, AppSettings appSettings) async {
  if (!appSettings.developerMode) appSettings.toggleDeveloperMode();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.claimPendingDev)));
  await tester.tap(find.byKey(const Key(EWTestKeys.claimPendingDev)));
  await tester.pumpAndSettle();
}
