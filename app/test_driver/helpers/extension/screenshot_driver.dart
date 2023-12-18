import 'dart:developer';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

import '../helper.dart';

part 'screenshots_name.dart';

extension ScreenshotExtension on FlutterDriver {
  static final _locales = Expando<List<String>>();

  List<String> get locales => _locales[this] ?? <String>[];
  set locales(List<String> x) => _locales[this] = x;

  Future<void> takeLocalScreenshot(
    String name, {
    String directory = '../screenshots',
    Duration timeout = const Duration(seconds: 30),
    bool waitUntilNoTransientCallbacks = true,
  }) async {
    if (await canDriverTakeScreenshot() &&
        locales.contains('en') &&
        !File('../screenshots/en/$name.png').existsSync()) {
      await requestData(TestCommand.devModeOff);
      for (final locale in locales) {
        final currenLocale = await requestData('local-$locale');
        await takeScreenshot(
          name,
          directory: '$directory/$currenLocale',
          timeout: timeout,
          waitUntilNoTransientCallbacks: waitUntilNoTransientCallbacks,
        );
      }
    }
  }

  Future<void> takeScreenshot(
    String name, {
    String directory = '../screenshots',
    Duration timeout = const Duration(seconds: 30),
    bool waitUntilNoTransientCallbacks = true,
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

  Future<bool> canDriverTakeScreenshot() async {
    final operationSystem = await requestData(TestCommand.getPlatform);
    log('operationSystem ==================> $operationSystem');
    return operationSystem == 'android';
  }
}
