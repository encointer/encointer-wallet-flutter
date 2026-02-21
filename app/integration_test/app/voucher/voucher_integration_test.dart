import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';
import '../app.dart';

Future<void> getQrVoucherAndFund(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await scrollToPanelController(tester);
  await goToTransferViewFromHomeView(tester);
  await voucherGetToTransferPageThenToVoucher(tester);
  await fundVoucher(tester, binding, appSettings, locales);
}

Future<void> scanVoucherFromQrScanPage(WidgetTester tester) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.mockQrDataRow)));
  await tester.tap(find.byKey(const Key(EWTestKeys.voucherToScan)));
  await tester.pumpAndSettle();
}

Future<void> voucherGetToTransferPageThenToVoucher(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.openQrScannerOnSendPage)));
  await tester.pumpAndSettle();
  await scanVoucherFromQrScanPage(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.voucherToTransferPage)));
  await tester.tap(find.byKey(const Key(EWTestKeys.voucherToTransferPage)));
  await tester.pumpAndSettle();
}

Future<void> fundVoucher(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferListview)));
  await tester.tap(find.byKey(const Key(EWTestKeys.transferAmountInput)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.transferAmountInput)), '0.3');
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.sendView, locales: locales);

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransfer)));
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.tap(find.byKey(const Key(EWTestKeys.makeTransferSend)));
  await tester.pumpAndSettle();

  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.transferDone)));
  await takeScreenshot(binding, appSettings, Screenshots.txConfirmationView, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.transferDone)));
  await tester.pumpAndSettle();
  await Future<void>.delayed(const Duration(milliseconds: 1000));
}

Future<void> getQrVoucherAndRedeem(WidgetTester tester) async {
  await navigateToScanPage(tester);
  await scanVoucherFromQrScanPage(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.submitVoucher)));
  await tester.tap(find.byKey(const Key(EWTestKeys.submitVoucher)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.voucherDialogOk)));
  await tester.tap(find.byKey(const Key(EWTestKeys.voucherDialogOk)));
  await tester.pumpAndSettle();
}
