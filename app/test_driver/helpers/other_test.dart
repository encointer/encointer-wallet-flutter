import 'package:flutter_driver/flutter_driver.dart';

import 'add_delay.dart';
import 'real_app_helper.dart';
import 'screenshots.dart';

Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('transfer-listview'),
    find.byValueKey('send-to-address'),
    dyScroll: -300,
  );
}

Future<void> createAccountAndSetPin(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('create-account'));
  await driver.waitFor(find.byValueKey('create-account-name'));
  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(account);
  await takeScreenshot(driver, Screenshots.createAccount);
  await driver.tap(find.byValueKey('create-account-next'));

  await driver.waitFor(find.byValueKey('create-account-pin'));
  await driver.tap(find.byValueKey('create-account-pin'));
  await driver.enterText('0001');

  await driver.tap(find.byValueKey('create-account-pin2'));
  await driver.enterText('0001');

  await takeScreenshot(driver, Screenshots.pinEntry);
  await driver.tap(find.byValueKey('create-account-confirm'));
}

Future<void> createNewbieAccount(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey('add-account-panel'));

  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(account);
  await driver.tap(find.byValueKey('create-account-confirm'));

  await closePanel(driver);
}

Future<void> sendMoneyToAccount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('transfer-amount-input'));
  await driver.tap(find.byValueKey('transfer-amount-input'));
  await driver.enterText('0.2');

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey('make-transfer'));
    await driver.tap(find.byValueKey('make-transfer'));

    await driver.waitFor(find.byValueKey('make-transfer-send'));
    await driver.tap(find.byValueKey('make-transfer-send'));
    await driver.waitFor(find.byValueKey('transfer-done'));
    await driver.tap(find.byValueKey('transfer-done'));
    await addDelay(1000);
  });
}

Future<void> shareAccount(FlutterDriver driver, String account, {bool shouldTakeScreenshot = false}) async {
  await driver.tap(find.byValueKey('profile'));
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.profileView);
  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));

  await driver.waitFor(find.byValueKey('go-to-account-share'));
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.accountManageView);
  await driver.tap(find.byValueKey('go-to-account-share'));
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.accountShareView);

  await addDelay(800);
  await driver.waitFor(find.byValueKey('close-share-page'));
  await driver.tap(find.byValueKey('close-share-page'));
  await addDelay(500);
}

Future<void> accountChangeName(FlutterDriver driver, String changedName, {bool shouldTakeScreenshot = false}) async {
  await driver.waitFor(find.byValueKey('account-name-edit'));
  await driver.tap(find.byValueKey('account-name-edit'));
  await addDelay(500);

  await driver.waitFor(find.byValueKey('account-name-field'));
  await driver.tap(find.byValueKey('account-name-field'));
  await driver.enterText(changedName);
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.changeAccountName);

  await driver.tap(find.byValueKey('account-name-edit-check'));
  await addDelay(700);
  await driver.waitFor(find.text(changedName));
  await addDelay(1000);
}

Future<void> accountExport(FlutterDriver driver, {bool shouldTakeScreenshot = false}) async {
  await driver.tap(find.byValueKey('popup-menu-account-trash-export'));
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.accountOptionsDialog);
  await driver.tap(find.byValueKey('export'));
  await driver.tap(find.byValueKey('input-password-dialog'));
  await driver.enterText('0001');
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.accountPasswordDialog);
  await driver.tap(find.byValueKey('password-ok'));

  await driver.waitFor(find.byValueKey('account-mnemonic-key'));
  if (shouldTakeScreenshot) await takeScreenshot(driver, Screenshots.exportAccountView);
  await addDelay(1000);
  await driver.tap(find.pageBack());
}

Future<void> deleteAccountFromAccountManagePage(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));
  await accountDeleteFromAccountManagePage(driver);
}

Future<void> accountDeleteFromAccountManagePage(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('popup-menu-account-trash-export'));
  await driver.tap(find.byValueKey('delete'));
  await driver.waitFor(find.byValueKey('delete-account'));
  await driver.tap(find.byValueKey('delete-account'));
}

Future<void> rmAllAccountsFromProfilePage(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('remove-all-accounts'));
  await driver.waitFor(find.byValueKey('remove-all-accounts-check'));
  await driver.tap(find.byValueKey('remove-all-accounts-check'));
  await driver.waitFor(find.byValueKey('import-account'));
}

Future<void> sendMoney(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('transfer'));
  await driver.waitFor(find.byValueKey('transfer-listview'));
  await driver.tap(find.byValueKey('transfer-amount-input'));

  await driver.enterText('0.1');
  await driver.tap(find.byValueKey('transfer-select-account'));
  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));
  await addDelay(2000);

  await driver.runUnsynchronized(() async {
    await driver.waitFor(find.byValueKey('make-transfer'));
    await driver.tap(find.byValueKey('make-transfer'));

    await driver.waitFor(find.byValueKey('make-transfer-send'));
    await driver.tap(find.byValueKey('make-transfer-send'));
    await driver.waitFor(find.byValueKey('transfer-done'));
    await driver.tap(find.byValueKey('transfer-done'));
    await addDelay(1000);
  });
}
