import 'dart:async';
import 'dart:io';

import 'package:encointer_wallet/app/wallet_app.dart';
import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:encointer_wallet/mocks/storage/mock_storage_setup.dart';
import 'package:encointer_wallet/mocks/storage/prepare_mock_storage.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart' as service_locator;
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  await runMain();
}

Future<void> runMain() async {
  await runZonedGuarded(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setEnvironment(Environment.integrationTest);

    service_locator.init(isTest: true);
    await service_locator.sl.allReady();

    // wait for the service locator to run
    await Future.delayed(const Duration(milliseconds: 200), () {});

    final globalAppStore = service_locator.sl.get<AppStore>();

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

    // Call the `main()` function of the app, or call `runApp` with
    // any widget you are interested in testing.

    runApp(
      const WalletApp(),
    );
  }, (error, StackTrace stackTrace) {
    Log.e('test_driver: => app.dart', error.toString(), stackTrace);
  });
}
