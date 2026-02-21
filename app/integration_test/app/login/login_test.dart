import 'dart:io';

import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> verifyAuthCancel(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.inputPasswordDialog)));
  await tester.tap(find.byKey(const Key(EWTestKeys.cancelButton)));
  await tester.pumpAndSettle();
}

Future<void> verifyInputPin(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.inputPasswordDialog)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.inputPasswordDialog)), EWTestKeys.testPIN);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(EWTestKeys.passwordOk)));
  await tester.pumpAndSettle();
}

Future<void> tapNotNowButtonBiometricAuthEnable(WidgetTester tester) async {
  final value = Platform.isAndroid ? 'Device not supported' : '';
  if (value.isEmpty) {
    await waitForWidget(tester, find.byKey(const Key(EWTestKeys.notNowButton)));
    await tester.tap(find.byKey(const Key(EWTestKeys.notNowButton)));
    await tester.pumpAndSettle();
  }
}
