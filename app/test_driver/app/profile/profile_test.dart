import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';
import 'profile_helper.dart';

Future<void> turnDevMode(FlutterDriver driver) async {
  await driver.takeLocalScreenshot(Screenshots.profileView);
  await scrollToDevMode(driver);
  await tapDevMode(driver);
}

Future<void> goToNetworkView(FlutterDriver driver) async {
  await scrollToNextPhaseButton(driver);
  await driver.tap(find.byValueKey('choose-network'));
}

Future<void> getNextPhase(FlutterDriver driver) async {
  await driver.requestData(TestCommand.devModeOn);
  await scrollToNextPhaseButton(driver);
  await tapNextPhase(driver);
}

Future<void> checkPeputationCount(FlutterDriver driver, int count) async {
  await driver.waitFor(find.text('$count'));
}

Future<void> deleteAllAccount(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('remove-all-accounts'));
  await driver.tap(find.byValueKey('remove-all-accounts'));
}
