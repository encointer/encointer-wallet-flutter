import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';
import '../home/home_helper.dart';
import '../navigate.dart';
import 'dev_qr_codes_test_helpers.dart';

Future<void> qrFromHomeTestAndSaveContact(WidgetTester tester) async {
  await navigateToScanPage(tester);
  await saveContactFromQrContact(tester);
}

Future<void> qrFromHomeTestAndSendWithAmount(WidgetTester tester) async {
  await navigateToScanPage(tester);
  await sendFromQrWithAmount(tester);
}

Future<void> qrFromHomeTestAndSendWithoutAmount(WidgetTester tester) async {
  await navigateToScanPage(tester);
  await sendFromQrWithoutAmount(tester);
}

Future<void> qrFromSendPageTestAndSendWithAmount(WidgetTester tester) async {
  await scrollToPanelController(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transfer)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transfer)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.openQrScannerOnSendPage)));
  await tester.tap(find.byKey(const Key(EWTestKeys.openQrScannerOnSendPage)));
  await tester.pumpAndSettle();
  await sendFromQrWithAmount(tester);
}

Future<void> qrFromSendPageTestAndSendWithoutAmount(WidgetTester tester) async {
  await scrollToPanelController(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transfer)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transfer)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.openQrScannerOnSendPage)));
  await tester.tap(find.byKey(const Key(EWTestKeys.openQrScannerOnSendPage)));
  await tester.pumpAndSettle();
  await sendFromQrWithoutAmount(tester);
}

Future<void> qrFromContactAddContactFromQrContact(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.addContact)));
  await tester.tap(find.byKey(const Key(EWTestKeys.addContact)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.scanBarcode)));
  await tester.tap(find.byKey(const Key(EWTestKeys.scanBarcode)));
  await tester.pumpAndSettle();
  await saveContactFromQrContact(tester, true);
  await Future<void>.delayed(const Duration(milliseconds: 500));
}
