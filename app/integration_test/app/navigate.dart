import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/wait_helpers.dart';

Future<void> goToCreateAccountViewFromAcoountEntryView(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccount)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountName)));
}

Future<void> goToReceiveViewFromHomeView(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.qrReceive)));
  await tester.pumpAndSettle();
}

Future<void> goToProfileViewFromNavBar(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.profile)));
  await tester.pumpAndSettle();
}

Future<void> goToHomeViewFromNavBar(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.wallet)));
  await tester.pumpAndSettle();
}

Future<void> goToAddAcoountViewFromPanel(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.panelController)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(EWTestKeys.addAccountPanel)));
  await tester.pumpAndSettle();
}

Future<void> goToTransferViewFromHomeView(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.transfer)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferListview)));
}

Future<void> goToContactViewFromNavBar(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.contacts)));
  await tester.pumpAndSettle();
}

Future<void> navigateToHomePage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.bottomNav)));
  await tester.tap(find.byKey(const Key(EWTestKeys.wallet)));
  await tester.pumpAndSettle();
}

Future<void> navigateToScanPage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.bottomNav)));
  await tester.tap(find.byKey(const Key(EWTestKeys.scan)));
  await tester.pumpAndSettle();
}

Future<void> navigateToContactsPage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.bottomNav)));
  await tester.tap(find.byKey(const Key(EWTestKeys.contacts)));
  await tester.pumpAndSettle();
}

Future<void> navigateToProfilePage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.bottomNav)));
  await tester.tap(find.byKey(const Key(EWTestKeys.profile)));
  await tester.pumpAndSettle();
}

Future<void> navigateToTransferHistoryPage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.goTransferHistory)));
  await tester.tap(find.byKey(const Key(EWTestKeys.goTransferHistory)));
  await tester.pumpAndSettle();
}
