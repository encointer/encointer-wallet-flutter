import 'dart:developer';

import 'package:flutter_driver/flutter_driver.dart';

import '../command/real_app_command.dart';

Future<void> dismissUpgradeDialogOnAndroid(FlutterDriver driver) async {
  final operationSystem = await driver.requestData(RealAppTestCommand.getPlatform);
  // ignore: avoid_print
  print('operationSystem ==================> $operationSystem');

  if (operationSystem == 'android') {
    try {
      log('Waiting for upgrader alert dialog');
      await driver.waitFor(find.byType('AlertDialog'));

      log('Tapping ignore button');
      await driver.tap(find.text('IGNORE'));
    } catch (e) {
      log(e.toString());
    }
  }
}
