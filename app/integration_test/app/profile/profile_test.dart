import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';
import 'profile_helper.dart';

Future<void> turnDevMode(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await takeScreenshot(binding, appSettings, Screenshots.profileView, locales: locales);
  await scrollToDevMode(tester);
  await tapDevMode(tester);
}

Future<void> goToNetworkView(WidgetTester tester) async {
  await scrollToNextPhaseButton(tester);
  await tester.tap(find.byKey(const Key(EWTestKeys.chooseNetwork)));
  await tester.pumpAndSettle();
}

Future<void> getNextPhase(WidgetTester tester, AppSettings appSettings) async {
  if (!appSettings.developerMode) appSettings.toggleDeveloperMode();
  await scrollToNextPhaseButton(tester);
  await tapNextPhase(tester);
}

Future<void> checkReputationCount(WidgetTester tester, int count) async {
  await waitForWidget(tester, find.text('$count'));
}

Future<void> deleteAllAccount(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.removeAllAccounts)));
  await tester.tap(find.byKey(const Key(EWTestKeys.removeAllAccounts)));
  await tester.pumpAndSettle();
}
