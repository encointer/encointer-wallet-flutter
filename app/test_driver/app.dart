import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;
import 'package:encointer_wallet/modules/modules.dart';

import 'helpers/helper.dart';

part 'helpers/command/app_functions.dart';

void main() async {
  const shouldTakeScreenshot = String.fromEnvironment('locales');
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';

  late final AppSettings appSettings;
  final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

  enableFlutterDriverExtension(
    handler: (command) async {
      switch (command) {
        case AppTestCommand.getPlatform:
          return Platform.operatingSystem;
        case AppTestCommand.locales:
          return shouldTakeScreenshot;
        case AppTestCommand.localeEn:
          return changeLocale(appSettings, 'en');
        case AppTestCommand.localeDe:
          return changeLocale(appSettings, 'de');
        case AppTestCommand.localeFr:
          return changeLocale(appSettings, 'fr');
        case AppTestCommand.localeRu:
          return changeLocale(appSettings, 'ru');
        case AppTestCommand.devModeOn:
          return toggleDeveloperMode(appSettings, true);
        case AppTestCommand.devModeOff:
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
  await app.main(appCast: cfg, settings: appSettings);
}
