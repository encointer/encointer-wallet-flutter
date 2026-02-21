import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> scrollToDevMode(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.profileListView)),
    item: find.byKey(const Key(EWTestKeys.devMode)),
  );
}

Future<void> scrollToNextPhaseButton(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.profileListView)),
    item: find.byKey(const Key(EWTestKeys.nextPhaseButton)),
    dyScroll: -100,
  );
}

Future<void> tapDevMode(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.devMode)));
  await tester.pumpAndSettle();
}

Future<void> tapNextPhase(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.nextPhaseButton)));
  await tester.tap(find.byKey(const Key(EWTestKeys.nextPhaseButton)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byType(SnackBar));
}
