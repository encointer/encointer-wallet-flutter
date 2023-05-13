import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

extension ScreenshotExtension on FlutterDriver {
  static final _shouldTakeScreenshot = Expando<String>();

  String get shouldTakeScreenshot => _shouldTakeScreenshot[this] ?? 'A';
  set shouldTakeScreenshot(String x) => _shouldTakeScreenshot[this] = x;

  Future<void> takeScreenshot(
    String name, {
    String directory = '../screenshots',
    Duration timeout = const Duration(seconds: 30),
    bool waitUntilNoTransientCallbacks = true,
  }) async {
    if (shouldTakeScreenshot == 'B') {
      await _takeScreenshot(
        name,
        directory: directory,
        timeout: timeout,
        waitUntilNoTransientCallbacks: waitUntilNoTransientCallbacks,
      );
    } else if (shouldTakeScreenshot == 'C') {
      const locales = ['de', 'fr', 'ru', 'en'];
      for (final locale in locales) {
        final currenLocale = await requestData('local-$locale');
        await _takeScreenshot(
          name,
          directory: '$directory/$currenLocale',
          timeout: timeout,
          waitUntilNoTransientCallbacks: waitUntilNoTransientCallbacks,
        );
      }
    }
  }

  Future<void> _takeScreenshot(
    String name, {
    required String directory,
    required Duration timeout,
    required bool waitUntilNoTransientCallbacks,
  }) async {
    if (waitUntilNoTransientCallbacks) {
      await this.waitUntilNoTransientCallbacks(timeout: timeout);
    }
    final pixels = await screenshot();
    final directoryPath = directory.endsWith('/') ? directory : '$directory/';
    final file = await File('$directoryPath$name.png').create(recursive: true);
    await file.writeAsBytes(pixels);
    // ignore: avoid_print
    print('Screenshot $name created at ${file.path}');
  }
}
