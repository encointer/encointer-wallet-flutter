import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';
import 'contact_helper.dart';

Future<void> checkContactEmpty(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await takeScreenshot(binding, appSettings, Screenshots.contactsOverviewEmpty, locales: locales);
}

Future<void> addContact(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String name,
  String pubKey,
) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.addContact)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.addContact, locales: locales);
  await enterConatctNameAndPubkey(tester, name, pubKey);
  await tester.tap(find.byKey(const Key(EWTestKeys.contactSave)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(Key(name)));
}

Future<void> contactDetailView(WidgetTester tester, String name) async {
  await waitForWidget(tester, find.byKey(Key(name)));
  await tester.tap(find.byKey(Key(name)));
  await tester.pumpAndSettle();
}

Future<void> changeContactName(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String name,
  String newName,
) async {
  await contactDetailView(tester, name);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.contactNameEdit)));
  await takeScreenshot(binding, appSettings, Screenshots.contactView, locales: locales);
  await enterChangeContactName(tester, newName);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.contactNameEditCheck)));
  await tester.tap(find.byKey(const Key(EWTestKeys.contactNameEditCheck)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text(newName));
  await takeScreenshot(binding, appSettings, Screenshots.changeContactName, locales: locales);
}

Future<void> sendEndorse(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.tapEndorseButton)));
  await tester.tap(find.byKey(const Key(EWTestKeys.tapEndorseButton)));
  await tester.pumpAndSettle();
}

Future<void> senMoneyToContact(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.sendMoneyToAccount)));
  await tester.tap(find.byKey(const Key(EWTestKeys.sendMoneyToAccount)));
  await tester.pumpAndSettle();
}
