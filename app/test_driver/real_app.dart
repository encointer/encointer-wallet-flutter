import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;
import 'package:encointer_wallet/modules/modules.dart';

import 'helpers/command/real_app_command.dart';

part 'helpers/command/real_app_functions.dart';

void main() async {
  const shouldTakeScreenshot = String.fromEnvironment('screenshot');
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';

  late final AppSettings appSettings;
  final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

  enableFlutterDriverExtension(
    handler: (command) async {
      switch (command) {
        case RealAppTestCommand.getPlatform:
          return Platform.operatingSystem;
        case RealAppTestCommand.shouldTakeScreenshot:
          return shouldTakeScreenshot;
        case RealAppTestCommand.localeEn:
          return changeLocale(appSettings, 'en');
        case RealAppTestCommand.localeDe:
          return changeLocale(appSettings, 'de');
        case RealAppTestCommand.localeFr:
          return changeLocale(appSettings, 'fr');
        case RealAppTestCommand.localeRu:
          return changeLocale(appSettings, 'ru');
        case RealAppTestCommand.devModeOn:
          return toggleDeveloperMode(appSettings, true);
        case RealAppTestCommand.devModeOff:
          return toggleDeveloperMode(appSettings, false);
        default:
          return '';
      }
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Clear settings to make upgrade dialog visible in subsequent test runs.
  await Upgrader.clearSavedSettings();
  appSettings = AppSettings(LangService(await SharedPreferences.getInstance()));
  WidgetsApp.debugAllowBannerOverride = false;
  await app.main(appCast: cfg, appSettings: appSettings);
}
