import 'package:encointer_wallet/app.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/mocks/storage/mock_storage_setup.dart';
import 'package:encointer_wallet/mocks/storage/prepare_mock_storage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // the tests are run in a separate isolate from the app. The test isolate can only interact with
  // the app via the driver in order to, for instance, configure the app state.
  // More info in: https://medium.com/stuart-engineering/mocking-integration-tests-with-flutter-af3b6ba846c7
  //
  // ignore: missing_return
  Future<String> dataHandler(String? msg) async {
    switch (msg) {
      case MockStorageSetup.WAIT_UNTIL_APP_IS_READY:
        return PrepareMockStorage.wait(globalAppStore);
      case MockStorageSetup.INIT:
        PrepareMockStorage.init(globalAppStore);
        break;
      case MockStorageSetup.HOME_PAGE:
        PrepareMockStorage.homePage(globalAppStore);
        break;
      case MockStorageSetup.READY_FOR_MEETUP:
        PrepareMockStorage.readyForMeetup(globalAppStore);
        break;
      default:
        break;
    }
    // to fix static analysis
    return Future.value("DataHandler");
  }

  enableFlutterDriverExtension(handler: dataHandler);
  WidgetsApp.debugAllowBannerOverride =
      false; // remove debug banner for screenshots

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(
    WalletApp(Config(
        mockLocalStorage: true,
        mockSubstrateApi: true,
        appStoreConfig: StoreConfig.Test)),
  );
}
