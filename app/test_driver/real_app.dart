import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;

import 'helpers/command/real_app_command.dart';

void main() async {
  const shouldTakeScreenshot = String.fromEnvironment('screenshot');
  enableFlutterDriverExtension(
    handler: (command) {
      var result = '';
      switch (command) {
        case RealAppTestCommand.getPlatform:
          result = Platform.operatingSystem;
          break;
        case RealAppTestCommand.shouldTakeScreenshot:
          result = shouldTakeScreenshot;
          break;
      }
      return Future.value(result);
    },
  );
  // Clear settings to make upgrade dialog visible in subsequent test runs.
  await Upgrader.clearSavedSettings();
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
  final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
  WidgetsApp.debugAllowBannerOverride = false;
  await app.main(appCast: cfg);
}
