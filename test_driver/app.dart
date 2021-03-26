import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/mocks/storage/prepareStorage.dart';
import 'package:encointer_wallet/mocks/storage/storageSetup.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/app.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {

  // ignore: missing_return
  Future<String> dataHandler(String msg) async {
    switch (msg) {
      case StorageSetup.UNREGISTERED_PARTICIPANT:
        {
          PrepareStorage.unregisteredParticipant(globalAppStore);
        }
        break;
      case StorageSetup.READY_FOR_MEETUP:
        {
          PrepareStorage.readyForMeetup(globalAppStore);
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
