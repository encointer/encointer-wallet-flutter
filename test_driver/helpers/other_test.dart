import 'package:flutter_driver/flutter_driver.dart';

import 'add_delay.dart';
import 'real_app_helper.dart';

Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('transfer-listview'),
    find.byValueKey('send-to-address'),
    dyScroll: -300,
  );
}

Future<void> createNewbieAccountAndSendMoney(FlutterDriver driver, String account) async {
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

Future<void> shareAccountAndChangeNameTest(FlutterDriver driver, String account, String changedName) async {
  await driver.tap(find.byValueKey('profile'));

  await driver.waitFor(find.byValueKey(account));
  await driver.tap(find.byValueKey(account));

  await driver.waitFor(find.byValueKey('go-to-account-share'));
  await driver.tap(find.byValueKey('go-to-account-share'));

  await addDelay(800);
  await driver.waitFor(find.byValueKey('close-share-page'));
  await driver.tap(find.byValueKey('close-share-page'));

  await driver.waitFor(find.byValueKey('account-name-edit'));
  await driver.tap(find.byValueKey('account-name-edit'));

  await driver.waitFor(find.byValueKey('account-name-field'));
  await driver.tap(find.byValueKey('account-name-field'));
  await driver.enterText(changedName);
  await driver.tap(find.byValueKey('account-name-edit-check'));
  await driver.waitFor(find.text(changedName));
  await addDelay(1000);

  await driver.tap(find.byValueKey('popup-menu-account-trash-export'));
  await driver.tap(find.byValueKey('export'));
  await driver.tap(find.byValueKey('input-password-dialog'));
  await driver.enterText('0001');
  await driver.tap(find.byValueKey('password-ok'));

  await driver.waitFor(find.byValueKey('account-mnemonic-key'));
  await addDelay(1000);
  await driver.tap(find.pageBack());

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
