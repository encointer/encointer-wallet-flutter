import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> enterNewAccountName(WidgetTester tester, String newName) async {
  final nameFieldFinder = find.byKey(const Key(EWTestKeys.accountNameField));
  // Set controller text directly — tester.enterText is unreliable when MobX
  // rebuilds (via context.watch<AppStore>()) disrupt the text input channel.
  final editableText = tester.widget<EditableText>(
    find.descendant(of: nameFieldFinder, matching: find.byType(EditableText)),
  );
  editableText.controller.text = newName;
  await tester.pumpAndSettle();
}

Future<void> enterPin(WidgetTester tester, String pin) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.inputPasswordDialog)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.inputPasswordDialog)), pin);
  await tester.pumpAndSettle();
}
