import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/helpers.dart';
import 'account_helper.dart';

Future<void> choosingCid(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  int index,
) async {
  await waitForWidget(tester, find.byKey(Key(EWTestKeys.cidMarkerIcon(index))));
  await tester.tap(find.byKey(Key(EWTestKeys.cidMarkerIcon(index))));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(Key(EWTestKeys.cidMarkerDescription(index))));
  await takeScreenshot(binding, appSettings, Screenshots.chooseCommunityMap, locales: locales);
  await tester.tap(find.byKey(Key(EWTestKeys.cidMarkerDescription(index))));
  await tester.pumpAndSettle();
}

Future<void> createAccount(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String account,
) async {
  await takeScreenshot(binding, appSettings, Screenshots.createAccount, locales: locales);
  await enterAccountName(tester, account);
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountNext)));
  await tester.pumpAndSettle();
}

Future<void> createPin(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String pin,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountPin)));
  await takeScreenshot(binding, appSettings, Screenshots.pinEntry, locales: locales);
  await enterPin(tester, EWTestKeys.testPIN);
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountConfirm)));
  await tester.pumpAndSettle();
}

Future<void> createNewbieAccount(WidgetTester tester, String account) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountName)));
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountName)));
  await tester.pumpAndSettle();
  await enterAccountName(tester, account);
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountConfirm)));
  await tester.pumpAndSettle();
}

Future<void> importAccount(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String accountName,
  String seedOrMnemonic,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.importAccount)));
  await tester.tap(find.byKey(const Key(EWTestKeys.importAccount)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.importAccount, locales: locales);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountName)));
  await enterAccountName(tester, accountName);
  await enterAccountMnemonic(tester, seedOrMnemonic);
  await tester.tap(find.byKey(const Key(EWTestKeys.accountImportNext)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.panelController)));
}
