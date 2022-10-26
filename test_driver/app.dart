import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/mocks/storage/mock_local_storage.dart';
import 'package:encointer_wallet/mocks/storage/mock_storage_setup.dart';
import 'package:encointer_wallet/mocks/storage/prepare_mock_storage.dart';
import 'package:encointer_wallet/store/app.dart';

void main() async {
  final _appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
  final _cfg = AppcastConfiguration(url: _appcastURL, supportedOS: ['android']);
  final _globalAppStore = AppStore(
    MockLocalStorage(),
    config: const AppConfig(mockSubstrateApi: true, appStoreConfig: StoreConfig.Test),
    appcastConfiguration: _cfg,
  );

  // the tests are run in a separate isolate from the app. The test isolate can only interact with
  // the app via the driver in order to, for instance, configure the app state.
  // More info in: https://medium.com/stuart-engineering/mocking-integration-tests-with-flutter-af3b6ba846c7
  //
  // ignore: missing_return
  Future<String> dataHandler(String? msg) async {
    var result = '';
    switch (msg) {
      case TestCommands.WAIT_UNTIL_APP_IS_READY:
        return PrepareMockStorage.wait(_globalAppStore);
      case TestCommands.INIT:
        PrepareMockStorage.init(_globalAppStore);
        break;
      case TestCommands.HOME_PAGE:
        PrepareMockStorage.homePage(_globalAppStore);
        break;
      case TestCommands.READY_FOR_MEETUP:
        PrepareMockStorage.readyForMeetup(_globalAppStore);
        break;
      case TestCommands.GET_PLATFORM:
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

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(
    Provider(
      create: (context) => _globalAppStore,
      child: const WalletApp(),
    ),
  );
}
