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
  final fieldFinder = find.byKey(const Key(EWTestKeys.accountSource));
  await waitForWidget(tester, fieldFinder);
  // Set controller text directly — tester.enterText tries to tap the field,
  // but the soft keyboard (still open from enterAccountName) intercepts the
  // tap, generating hit-test warnings that accumulate and fail the test.
  final editableText = tester.widget<EditableText>(
    find.descendant(of: fieldFinder, matching: find.byType(EditableText)),
  );
  editableText.controller.text = seedOrMnemonic;
  await tester.pumpAndSettle();
}

Future<void> enterPin(WidgetTester tester, String password) async {
  final pin1Finder = find.byKey(const Key(EWTestKeys.createAccountPin));
  await waitForWidget(tester, pin1Finder);
  // Set controller text directly — tap + enterText fails on iOS simulators
  // because the keyboard pushes pin2 out of the ListView viewport.
  final pin1Editable = tester.widget<EditableText>(
    find.descendant(of: pin1Finder, matching: find.byType(EditableText)),
  );
  pin1Editable.controller.text = password;
  await tester.pumpAndSettle();

  final pin2Finder = find.byKey(const Key(EWTestKeys.createAccountPin2));
  await waitForWidget(tester, pin2Finder);
  final pin2Editable = tester.widget<EditableText>(
    find.descendant(of: pin2Finder, matching: find.byType(EditableText)),
  );
  pin2Editable.controller.text = password;
  await tester.pumpAndSettle();
}
