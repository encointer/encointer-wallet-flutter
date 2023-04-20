import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;
import 'package:encointer_wallet/modules/modules.dart';

import 'helpers/command/real_app_command.dart';

void main() async {
  const shouldTakeScreenshot = String.fromEnvironment('screenshot');
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';

  late final AppSettings appSettings;
  final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

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
        case RealAppTestCommand.localeEn:
          result = appSettings.locale.languageCode;
          break;
      }
      return Future.value(result);
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Clear settings to make upgrade dialog visible in subsequent test runs.
  await Upgrader.clearSavedSettings();
  appSettings = AppSettings(LangService(await SharedPreferences.getInstance()));
  WidgetsApp.debugAllowBannerOverride = false;
  await app.main(appCast: cfg, appSettings: appSettings);
}
