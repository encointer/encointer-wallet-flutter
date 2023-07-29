import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import '../app.dart';
import 'account_manage_helper.dart';

Future<void> accountDetailPage(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));
}

Future<void> deleteAccountFromProfilePage(FlutterDriver driver, String account) async {
  await accountDetailPage(driver, account);
  await deleteAccountFromAccountManagePage(driver);
}

Future<void> deleteAccountFromAccountManagePage(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.popupMenuAccountTrashExport));
  await driver.tap(find.byValueKey(EWTestKeys.delete));
}

Future<String> getPublicKey(FlutterDriver driver, String accountName) async {
  await accountDetailPage(driver, accountName);
  await driver.waitFor(find.byValueKey(EWTestKeys.accountPublicKey));
  final publicKey = await driver.getText(find.byValueKey(EWTestKeys.accountPublicKey));
  await driver.tap(find.byValueKey(EWTestKeys.closeAccountManage));
  return publicKey;
}

Future<void> shareAccount(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.goToAccountShare));
  await driver.takeLocalScreenshot(Screenshots.accountManageView);
  await driver.tap(find.byValueKey(EWTestKeys.goToAccountShare));
  await driver.takeLocalScreenshot(Screenshots.accountShareView);
  await driver.waitFor(find.byValueKey(EWTestKeys.closeSharePage));
  await driver.tap(find.byValueKey(EWTestKeys.closeSharePage));
}

Future<void> accountChangeName(FlutterDriver driver, String newName) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.accountNameEdit));
  await driver.tap(find.byValueKey(EWTestKeys.accountNameEdit));
  await driver.waitFor(find.byValueKey(EWTestKeys.accountNameField));
  await driver.takeLocalScreenshot(Screenshots.changeAccountName);
  await enterNewAccountName(driver, newName);
  await driver.tap(find.byValueKey(EWTestKeys.accountNameEditCheck));
  await driver.waitFor(find.text(newName));
}

Future<String> exportAccount(FlutterDriver driver, String pin) async {
  await driver.tap(find.byValueKey(EWTestKeys.popupMenuAccountTrashExport));
  await driver.takeLocalScreenshot(Screenshots.accountOptionsDialog);
  await driver.tap(find.byValueKey(EWTestKeys.export));
  await driver.takeLocalScreenshot(Screenshots.accountPasswordDialog);
  await verifyInputPin(driver);
  await driver.waitFor(find.byValueKey(EWTestKeys.accountMnemonicKey));
  final mnemonic = await driver.getText(find.byValueKey(EWTestKeys.accountMnemonicKey));
  await driver.takeLocalScreenshot(Screenshots.exportAccountView);
  await driver.tap(find.pageBack());
  return mnemonic;
}
