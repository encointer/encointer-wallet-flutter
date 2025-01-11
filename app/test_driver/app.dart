import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/modules/modules.dart';

import 'helpers/helper.dart';

part 'helpers/command/app_functions.dart';

void main() async {
  const shouldTakeScreenshot = String.fromEnvironment('locales');
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';

  late final AppSettings appSettings;
  late final AppService appService;
  const appConfig = AppConfig(appCastUrl: appcastURL, isIntegrationTest: true);

  enableFlutterDriverExtension(
    handler: (command) async {
      switch (command) {
        case TestCommand.getPlatform:
          return Platform.operatingSystem;
        case TestCommand.locales:
          return shouldTakeScreenshot;
        case TestCommand.localeEn:
          return changeLocale(appSettings, 'en');
        case TestCommand.localeDe:
          return changeLocale(appSettings, 'de');
        case TestCommand.localeFr:
          return changeLocale(appSettings, 'fr');
        case TestCommand.localeRu:
          return changeLocale(appSettings, 'ru');
        case TestCommand.devModeOn:
          return toggleDeveloperMode(appSettings, true);
        case TestCommand.devModeOff:
          return toggleDeveloperMode(appSettings, false);
        case TestCommand.getBiometricAuthState:
          return getBiometricAuthState(appService);
        default:
          return '';
      }
    },
  );

  WidgetsFlutterBinding.ensureInitialized();
  // Clear settings to make upgrade dialog visible in subsequent test runs.
  await Upgrader.clearSavedSettings();
  appService = AppService(await SharedPreferences.getInstance());
  appSettings = AppSettings(appService)..isIntegrationTest = true;

  WidgetsApp.debugAllowBannerOverride = false;
  await app.main(appConfig: appConfig, settings: appSettings);
}
