import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/app.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {

  //
  Future<String> dataHandler(String msg) async {
    switch (msg) {
      case SETUP_STORE:
        {
          setupAppStorage(globalAppStore);
        }
        break;
      default:
        break;
    }
  }

  enableFlutterDriverExtension(handler: dataHandler);

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  runApp(
    WalletApp(Config(mockLocalStorage: true, mockSubstrateApi: true)),
  );
}

const SETUP_STORE = 'setup_store';

void setupAppStorage(AppStore store) {
  print("[test_driver] setting up AppStore");
  // store.account.setPin("1234");
}