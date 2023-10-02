import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> goToCreateAccountViewFromAcoountEntryView(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.createAccount));
  await driver.waitFor(find.byValueKey(EWTestKeys.createAccountName));
}

Future<void> goToReceiveViewFromHomeView(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.qrReceive));
}

Future<void> goToProfileViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.profile));
}

Future<void> goToHomeViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.wallet));
}

Future<void> goToAddAcoountViewFromPanel(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.panelController));
  await driver.tap(find.byValueKey(EWTestKeys.addAccountPanel));
}

Future<void> goToTransferViewFromHomeView(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.transfer));
  await driver.waitFor(find.byValueKey(EWTestKeys.transferListview));
}

Future<void> goToContactViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.contacts));
}

Future<void> navigateToHomePage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.bottomNav));
  await driver.tap(find.byValueKey(EWTestKeys.wallet));
}

Future<void> navigateToScanPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.bottomNav));
  await driver.tap(find.byValueKey(EWTestKeys.scan));
}

Future<void> navigateToContactsPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.bottomNav));
  await driver.tap(find.byValueKey(EWTestKeys.contacts));
}

Future<void> navigateToProfilePage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.bottomNav));
  await driver.tap(find.byValueKey(EWTestKeys.profile));
}

Future<void> navigateToTransferHistoryPage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.goTransferHistory));
  await driver.tap(find.byValueKey(EWTestKeys.goTransferHistory));
}
