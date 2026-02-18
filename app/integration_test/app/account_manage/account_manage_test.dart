import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:encointer_wallet/modules/modules.dart';

import '../../helpers/screenshot_helpers.dart';
import '../../helpers/wait_helpers.dart';
import '../app.dart';
import 'account_manage_helper.dart';

Future<void> accountDetailPage(WidgetTester tester, String account) async {
  await waitForWidget(tester, find.byKey(Key(account)));
  await tester.tap(find.byKey(Key(account)));
  await tester.pumpAndSettle();
}

Future<void> deleteAccountFromProfilePage(WidgetTester tester, String account) async {
  await accountDetailPage(tester, account);
  await deleteAccountFromAccountManagePage(tester);
}

Future<void> deleteAccountFromAccountManagePage(WidgetTester tester) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.popupMenuAccountTrashExport)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key(EWTestKeys.delete)));
  await tester.pumpAndSettle();
}

Future<String> getPublicKey(WidgetTester tester, String accountName) async {
  await accountDetailPage(tester, accountName);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountPublicKey)));
  final publicKey = tester.widget<Text>(find.byKey(const Key(EWTestKeys.accountPublicKey))).data!;
  await tester.tap(find.byKey(const Key(EWTestKeys.closeAccountManage)));
  await tester.pumpAndSettle();
  return publicKey;
}

Future<void> shareAccount(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String account,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.goToAccountShare)));
  await takeScreenshot(binding, appSettings, Screenshots.accountManageView, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.goToAccountShare)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.accountShareView, locales: locales);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.closeSharePage)));
  await tester.tap(find.byKey(const Key(EWTestKeys.closeSharePage)));
  await tester.pumpAndSettle();
}

Future<void> accountChangeName(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String newName,
) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountNameEdit)));
  await tester.tap(find.byKey(const Key(EWTestKeys.accountNameEdit)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountNameField)));
  await takeScreenshot(binding, appSettings, Screenshots.changeAccountName, locales: locales);
  await enterNewAccountName(tester, newName);
  await tester.tap(find.byKey(const Key(EWTestKeys.accountNameEditCheck)));
  await tester.pumpAndSettle();
  await waitForWidget(tester, find.text(newName));
}

Future<String> exportAccount(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
  AppSettings appSettings,
  List<String> locales,
  String pin,
) async {
  await tester.tap(find.byKey(const Key(EWTestKeys.popupMenuAccountTrashExport)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.accountOptionsDialog, locales: locales);
  await tester.tap(find.byKey(const Key(EWTestKeys.export)));
  await tester.pumpAndSettle();
  await takeScreenshot(binding, appSettings, Screenshots.accountPasswordDialog, locales: locales);
  await verifyInputPin(tester);
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.accountMnemonicKey)));
  final mnemonic = tester.widget<Text>(find.byKey(const Key(EWTestKeys.accountMnemonicKey))).data!;
  await takeScreenshot(binding, appSettings, Screenshots.exportAccountView, locales: locales);
  await tester.tap(find.byTooltip('Back'));
  await tester.pumpAndSettle();
  return mnemonic;
}
