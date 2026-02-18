import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> changeDevNetwork(WidgetTester tester, String account) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.nctrGslDev)));
  await tester.tap(find.byKey(const Key(EWTestKeys.nctrGslDev)));
  await tester.pumpAndSettle();
  await tester.tap(find.text(account));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.profileListView)));
}
