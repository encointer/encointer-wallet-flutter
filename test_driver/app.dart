import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/storage/mock_storage_setup.dart';
import 'package:encointer_wallet/mocks/storage/prepare_mock_storage.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';

void main() async {
  const appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
  final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
  final globalAppStore = AppStore(
    MockLocalStorage(),
    config: AppConfig(mockSubstrateApi: true, isTestMode: true, appCast: cfg),
  );

  // the tests are run in a separate isolate from the app. The test isolate can only interact with
  // the app via the driver in order to, for instance, configure the app state.
  // More info in: https://medium.com/stuart-engineering/mocking-integration-tests-with-flutter-af3b6ba846c7
  //
  // ignore: missing_return
  Future<String> dataHandler(String? msg) async {
    var result = '';
    switch (msg) {
      case TestCommands.waitUntilAppIsReady:
        return PrepareMockStorage.wait(globalAppStore);
      case TestCommands.init:
        await PrepareMockStorage.init(globalAppStore);
        break;
      case TestCommands.homePage:
        PrepareMockStorage.homePage(globalAppStore);
        break;
      case TestCommands.readyForMeetup:
        PrepareMockStorage.readyForMeetup(globalAppStore);
        break;
      case TestCommands.getPlatform:
        result = Platform.operatingSystem;
        break;
      default:
        break;
    }
    return result;
  }

  enableFlutterDriverExtension(handler: dataHandler);
  WidgetsApp.debugAllowBannerOverride = false; // remove debug banner for screenshots

  // Clear settings to make upgrade dialog visible in subsequent test runs.
  await Upgrader.clearSavedSettings();
  final localService = LangService(await SharedPreferences.getInstance());

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(
    MultiProvider(
      providers: [
        Provider<AppSettings>(
          create: (context) => AppSettings(localService)..init(),
        ),
        Provider<AppStore>(
          // On test mode instead of LocalStorage() must be use MockLocalStorage()
          create: (context) => globalAppStore,
        )
      ],
      child: const WalletApp(),
    ),
  );
}
