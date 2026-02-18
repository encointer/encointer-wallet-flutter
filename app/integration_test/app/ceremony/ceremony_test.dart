import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';
import 'ceremony_helper.dart';

Future<void> startMeetupTest(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales, {
  int participantsCount = 3,
}) async {
  await takeScreenshot(binding, appSettings, Screenshots.homeAttestingPhaseStartMeetup, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.startMeetup)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.step1ConfirmNumberOfAttendees, locales: locales);
  await enterAttendeesCount(tester, participantsCount);
  await tester.tap(find.byKey(const Key(EWTestKeys.ceremonyStep1Next)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.step2QrCode, locales: locales);
  if (!appSettings.developerMode) appSettings.toggleDeveloperMode();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.attestAllParticipantsDev)));
  await tester.tap(find.byKey(const Key(EWTestKeys.attestAllParticipantsDev)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byType(SnackBar));
  await tester.tap(find.byKey(const Key(EWTestKeys.closeMeetup)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.submitClaims)));
  await takeScreenshot(binding, appSettings, Screenshots.step3FinishGathering, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.submitClaims)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.restartMeetup)));
}
