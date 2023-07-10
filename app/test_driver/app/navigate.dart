import 'package:flutter_driver/flutter_driver.dart';

import 'transfer/transfer_keys.dart';

Future<void> goToCreateAccountViewFromAcoountEntryView(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('create-account'));
  await driver.waitFor(find.byValueKey('create-account-name'));
}

Future<void> goToReceiveViewFromHomeView(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('qr-receive'));
}

Future<void> goToProfileViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('profile'));
}

Future<void> goToHomeViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('wallet'));
}

Future<void> goToAddAcoountViewFromPanel(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('panel-controller'));
  await driver.tap(find.byValueKey('add-account-panel'));
}

Future<void> goToTransferViewFromHomeView(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('transfer'));
  await driver.waitFor(find.byValueKey(TransferKeys.transferListview));
}

Future<void> goToContactViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('contacts'));
}

Future<void> navigateToHomePage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('wallet'));
}

Future<void> navigateToScanPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('scan'));
}

Future<void> navigateToContactsPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('contacts'));
}

Future<void> navigateToProfilePage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('bottom-nav'));
  await driver.tap(find.byValueKey('profile'));
}

Future<void> navigateToTransferHistoryPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('go-transfer-history'));
  await driver.tap(find.byValueKey('go-transfer-history'));
}
