import 'package:flutter_driver/flutter_driver.dart';

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
  await driver.waitFor(find.byValueKey('transfer-listview'));
}

Future<void> goToContactViewFromNavBar(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('contacts'));
}
