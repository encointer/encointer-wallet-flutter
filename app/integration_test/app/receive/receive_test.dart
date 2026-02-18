import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';

Future<void> receiveView(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.closeReceivePage)));
  await takeScreenshot(binding, appSettings, Screenshots.receiveView, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.closeReceivePage)));
  await tester.pumpAndSettle();
}
