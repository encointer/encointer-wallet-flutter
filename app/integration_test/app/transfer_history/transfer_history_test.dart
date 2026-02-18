import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';

Future<void> checkTransferHistoryEmpty(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transactionsEmpty)));
  await takeScreenshot(binding, appSettings, Screenshots.txHistoryEmpty, locales: locales);
  await tester.tap(find.byTooltip('Back'));
  await tester.pumpAndSettle();
}

Future<void> checkTransferHistory(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transactionsList)));
  await takeScreenshot(binding, appSettings, Screenshots.txHistory, locales: locales);
  await tester.tap(find.byTooltip('Back'));
  await tester.pumpAndSettle();
}
