import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> enterConatctNameAndPubkey(WidgetTester tester, String name, String pubKey) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.contactAddress)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.contactAddress)), pubKey);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(EWTestKeys.contactName)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.contactName)), name);
  await tester.pumpAndSettle();
}

Future<void> enterChangeContactName(WidgetTester tester, String newName) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.contactNameEdit)));
  await tester.tap(find.byKey(const Key(EWTestKeys.contactNameEdit)));
  await tester.pumpAndSettle();
  final nameFieldFinder = find.byKey(const Key(EWTestKeys.contactNameField));
  await waitForWidget(tester, nameFieldFinder);
  // Set controller text directly — tester.enterText is unreliable when MobX
  // rebuilds (via context.watch<AppStore>()) disrupt the text input channel.
  final editableText = tester.widget<EditableText>(
    find.descendant(of: nameFieldFinder, matching: find.byType(EditableText)),
  );
  editableText.controller.text = newName;
  await tester.pumpAndSettle();
}
