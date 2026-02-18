import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> enterAccountName(WidgetTester tester, String accountName) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountName)));
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountName)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.createAccountName)), accountName);
  await tester.pumpAndSettle();
}

Future<void> enterAccountMnemonic(WidgetTester tester, String seedOrMnemonic) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountSource)));
  await tester.tap(find.byKey(const Key(EWTestKeys.accountSource)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.accountSource)), seedOrMnemonic);
  await tester.pumpAndSettle();
}

Future<void> enterPin(WidgetTester tester, String password) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountPin)));
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountPin)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.createAccountPin)), password);
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.createAccountPin2)));
  await tester.tap(find.byKey(const Key(EWTestKeys.createAccountPin2)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.createAccountPin2)), password);
  await tester.pumpAndSettle();
}
