import 'dart:io';

import 'package:flutter_driver/driver_extension.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;

import 'helpers/real_app_helper.dart';

// [ANDROID] flutter drive --target=test_driver/real_app.dart --flavor dev
// [Get IP addess and change local host for IOS] bash scripts/replace_localhost_with_local_network_address.sh
// [IOS] flutter drive --target=test_driver/real_app.dart

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
  final _appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
  final _cfg = AppcastConfiguration(url: _appcastURL, supportedOS: ['android']);
  await app.main(appCast: _cfg);
}
