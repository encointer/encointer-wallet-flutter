import 'dart:developer';
import 'dart:io';

import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/wait_helpers.dart';

Future<void> refreshWalletPage(WidgetTester tester) async {
  await tester.drag(find.byType(RefreshIndicator), const Offset(20, 300));
  await tester.pumpAndSettle();
}

Future<void> closePanel(WidgetTester tester) async {
  await tester.drag(find.byKey(const Key(EWTestKeys.dragHandlePanel)), const Offset(0, 300));
  await tester.pumpAndSettle();
}

Future<void> changeAccountFromPanel(WidgetTester tester, String account) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.panelController)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(Key(account)));
  await tester.tap(find.byKey(Key(account)));
  await tester.pumpAndSettle();
  await closePanel(tester);
}

Future<void> dismissUpgradeDialogOnAndroid(WidgetTester tester) async {
  final operationSystem = Platform.operatingSystem;
  log('operationSystem ==================> $operationSystem');
  if (operationSystem == 'android') {
    try {
      log('Waiting for upgrader alert dialog');
      await waitForWidget(tester, find.byType(AlertDialog));
      log('Tapping ignore button');
      await tester.tap(find.text('IGNORE'));
      await tester.pumpAndSettle();
    } catch (e) {
      log(e.toString());
    }
  }
}

Future<void> scrollToCeremonyBox(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.listViewWallet)),
    item: find.byKey(const Key(EWTestKeys.ceremonyBoxWallet)),
  );
}

Future<void> scrollToRegisterButton(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.listViewWallet)),
    item: find.byKey(const Key(EWTestKeys.registrationMeetupButton)),
  );
}

Future<void> scrollToUnregisterButton(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.listViewWallet)),
    item: find.byKey(const Key(EWTestKeys.unregisterButton)),
  );
}

Future<void> scrollToPanelController(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.listViewWallet)),
    item: find.byKey(const Key(EWTestKeys.panelController)),
    dyScroll: 400,
  );
}

Future<void> scrollToStartMeetup(WidgetTester tester, AppSettings appSettings) async {
  if (appSettings.developerMode) appSettings.toggleDeveloperMode();
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.listViewWallet)),
    item: find.byKey(const Key(EWTestKeys.startMeetup)),
  );
}
