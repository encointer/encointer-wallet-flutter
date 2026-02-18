import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> scrollToSendAddress(WidgetTester tester) async {
  await scrollUntilVisible(
    tester,
    scrollable: find.byKey(const Key(EWTestKeys.transferListview)),
    item: find.byKey(const Key(EWTestKeys.sendToAddress)),
  );
}

Future<void> enterTransferAmount(WidgetTester tester, String amount) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.transferAmountInput)), amount);
  await tester.pumpAndSettle();
}
