import 'dart:io';

import 'package:encointer_wallet/extras/config/build_options.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;

import 'helpers/real_app_helper.dart';

// [ANDROID] ./flutterw drive --target=test_driver/real_app.dart --flavor dev
// [IOS] ./flutterw drive --target=test_driver/real_app.dart

void main() async {
  enableFlutterDriverExtension(
    handler: (command) {
      var result = '';
      switch (command) {
        case getPlatformCommand:
          result = Platform.operatingSystem;
          break;
      }
      return Future.value(result);
    },
  );
  // Clear settings to make upgrade dialog visible in subsequent test runs.
  await Upgrader.clearSavedSettings();

  await app.main(environment: Environment.integrationTestRealApp);
}
