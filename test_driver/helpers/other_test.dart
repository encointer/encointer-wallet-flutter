import 'package:flutter_driver/flutter_driver.dart';

import 'add_delay.dart';
import 'real_app_helper.dart';

Future<void> scrollToSendAddress(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('transfer-listview'),
    find.byValueKey('send-to-address'),
    dyScroll: -300.0,
  );
}

Future<void> createNewbieAccountAndSendMoney(FlutterDriver driver, String account) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey('add-account-panel'));

  await driver.tap(find.byValueKey('create-account-name'));
  await driver.enterText(account);
  await driver.tap(find.byValueKey('create-account-confirm'));

  await driver.tap(find.byValueKey('Alice'));
  await closePanel(driver);

  await driver.tap(find.byValueKey('transfer'));
  await driver.tap(find.byValueKey('transfer-amount-input'));
  await driver.enterText('0.2');

  await driver.runUnsynchronized(() async {
    await scrollToSendAddress(driver);
    await driver.tap(find.byValueKey('send-to-address'));
    await driver.waitFor(find.byValueKey(account));
    // await driver.(find.byValueKey(account));

    await driver.waitFor(find.byValueKey('make-transfer'));
    await driver.tap(find.byValueKey('make-transfer'));

    await driver.waitFor(find.byValueKey('make-transfer-send'));
    await driver.tap(find.byValueKey('make-transfer-send'));
    await driver.waitFor(find.byValueKey('transfer-done'));
    await driver.tap(find.byValueKey('transfer-done'));
    await addDelay(1000);
    await driver.tap(find.byValueKey('panel-controller'));
    await driver.tap(find.byValueKey(account));
    await closePanel(driver);
    await addDelay(1000);
  });
}
