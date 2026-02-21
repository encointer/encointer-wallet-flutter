import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> sendFromQrWithAmount(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.mockQrDataRow)));
  await tester.tap(find.byKey(const Key(EWTestKeys.invoiceWithAmountToScan)));
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferDone)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferDone)));
  await tester.pumpAndSettle();
  await Future<void>.delayed(const Duration(milliseconds: 1000));
}

Future<void> sendFromQrWithoutAmount(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.mockQrDataRow)));
  await tester.tap(find.byKey(const Key(EWTestKeys.invoiceWithNoAmountToScan)));
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.transferAmountInput)), '0.01');
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferDone)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferDone)));
  await tester.pumpAndSettle();
  await Future<void>.delayed(const Duration(milliseconds: 1000));
}

Future<void> saveContactFromQrContact(WidgetTester tester, [bool contactToSaveToAddress = false]) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.mockQrDataRow)));

  if (contactToSaveToAddress) {
    await tester.tap(find.byKey(const Key(EWTestKeys.contactToSaveToAddress)));
  } else {
    await tester.tap(find.byKey(const Key(EWTestKeys.profileToScan)));
  }
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.contactSave)));
  await tester.tap(find.byKey(const Key(EWTestKeys.contactSave)));
  await tester.pumpAndSettle();
}

Future<void> saveContactFromQrInvoice(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.mockQrDataRow)));
  await tester.tap(find.byKey(const Key(EWTestKeys.invoiceToSaveToAddress)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.contactSave)));
  await tester.tap(find.byKey(const Key(EWTestKeys.contactSave)));
  await tester.pumpAndSettle();
}
