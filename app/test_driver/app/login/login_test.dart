import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> verifyAuthCancel(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.inputPasswordDialog));
  await driver.tap(find.byValueKey(EWTestKeys.cancelButton));
}

Future<void> verifyInputPin(FlutterDriver driver) async {
  await driver.tap(find.byValueKey(EWTestKeys.inputPasswordDialog));
  await driver.enterText(EWTestKeys.zero001);
  await driver.tap(find.byValueKey(EWTestKeys.passwordOk));
}

Future<void> tapNotNowButtonBiometricAuthEnable(FlutterDriver driver) async {
  final value = await driver.requestData(TestCommand.getBiometricAuthState);
  if (value.isEmpty) {
    await driver.waitFor(find.byValueKey(EWTestKeys.notNowButton));
    await driver.tap(find.byValueKey(EWTestKeys.notNowButton));
  }
}
