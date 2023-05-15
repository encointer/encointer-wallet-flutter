import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/command/real_app_command.dart';
import '../../helpers/extension/screenshot_driver_extension.dart';
import '../../helpers/screenshots/screenshots.dart';
import 'profile_helper.dart';

Future<void> turnDevMode(FlutterDriver driver) async {
  await driver.takeScreenshot(Screenshots.profileView);
  await scrollToDevMode(driver);
  await tapDevMode(driver);
}

Future<void> goToNetwotkView(FlutterDriver driver) async {
  await scrollToNextPhaseButton(driver);
  await driver.tap(find.byValueKey('choose-network'));
}

Future<void> getNextPhase(FlutterDriver driver) async {
  await driver.requestData(RealAppTestCommand.devModeOn);
  await scrollToNextPhaseButton(driver);
  await tapAndWaitNextPhase(driver);
}

Future<void> checkPeputationCount(FlutterDriver driver, int count) async {
  await driver.waitFor(find.text('$count'));
}
