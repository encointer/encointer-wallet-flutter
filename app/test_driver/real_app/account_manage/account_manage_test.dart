import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/extension/screenshot_driver.dart';
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
  await driver.tap(find.byValueKey('popup-menu-account-trash-export'));
  await driver.tap(find.byValueKey('delete'));
  await driver.waitFor(find.byValueKey('delete-account'));
  await driver.tap(find.byValueKey('delete-account'));
}

Future<String> getPublicKey(FlutterDriver driver, String accountName) async {
  await accountDetailPage(driver, accountName);
  await driver.waitFor(find.byValueKey('account-public-key'));
  final publicKey = await driver.getText(find.byValueKey('account-public-key'));
  await driver.tap(find.byValueKey('close-account-manage'));
  return publicKey;
}

Future<void> shareAccount(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey('go-to-account-share'));
  await driver.takeScreenshot(Screenshots.accountManageView);
  await driver.tap(find.byValueKey('go-to-account-share'));
  await driver.takeScreenshot(Screenshots.accountShareView);
  await driver.waitFor(find.byValueKey('close-share-page'));
  await driver.tap(find.byValueKey('close-share-page'));
}

Future<void> accountChangeName(FlutterDriver driver, String newName) async {
  await driver.waitFor(find.byValueKey('account-name-edit'));
  await driver.tap(find.byValueKey('account-name-edit'));
  await driver.waitFor(find.byValueKey('account-name-field'));
  await driver.takeScreenshot(Screenshots.changeAccountName);
  await enterNewAccountName(driver, newName);
  await driver.tap(find.byValueKey('account-name-edit-check'));
  await driver.waitFor(find.text(newName));
}

Future<String> exportAccount(FlutterDriver driver, String pin) async {
  await driver.tap(find.byValueKey('popup-menu-account-trash-export'));
  await driver.takeScreenshot(Screenshots.accountOptionsDialog);
  await driver.tap(find.byValueKey('export'));
  await driver.takeScreenshot(Screenshots.accountPasswordDialog);
  await enterPin(driver, pin);
  await driver.tap(find.byValueKey('password-ok'));
  await driver.waitFor(find.byValueKey('account-mnemonic-key'));
  final mnemonic = await driver.getText(find.byValueKey('account-mnemonic-key'));
  await driver.takeScreenshot(Screenshots.exportAccountView);
  await driver.tap(find.pageBack());
  return mnemonic;
}
