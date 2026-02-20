import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';
import 'transfer_helper.dart';

Future<void> senMoneyToAccount(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String recieveName,
  String amount,
) async {
  await takeScreenshot(binding, appSettings, Screenshots.sendView, locales: locales);
  await enterTransferAmount(tester, amount);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferSelectAccount)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferSelectAccount)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(Key(recieveName)));
  await tester.tap(find.byKey(Key(recieveName)));
  await tester.pumpAndSettle();
  await confirmTransaction(tester, binding, appSettings, locales);
}

Future<void> sendMoneyToSelectedAccount(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String amount,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.transferAmountInput)), amount);
  await tester.pumpAndSettle();
  await confirmTransaction(tester, binding, appSettings, locales);
}

Future<void> confirmTransaction(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferDone)));
  await takeScreenshot(binding, appSettings, Screenshots.txConfirmationView, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.transferDone)));
  await tester.pumpAndSettle();
}
