import 'package:flutter_driver/flutter_driver.dart';

import '../../helpers/helper.dart';

Future<void> verifyAuthCancel(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey('input-password-dialog'));
  await driver.tap(find.byValueKey('cancel-button'));
}

Future<void> verifyInputPin(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('input-password-dialog'));
  await driver.enterText('0001');
  await driver.tap(find.byValueKey('password-ok'));
}

Future<void> tapNotNowButtonBiometricAuthEnable(FlutterDriver driver) async {
  final value = await driver.requestData(TestCommand.getBiometricAuthState);
  if (value.isEmpty) {
    await driver.waitFor(find.byValueKey('not-now-button'));
    await driver.tap(find.byValueKey('not-now-button'));
  }
}
