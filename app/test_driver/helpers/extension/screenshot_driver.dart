import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

import '../command/real_app_command.dart';

part 'screenshots_name.dart';

extension ScreenshotExtension on FlutterDriver {
  static final _shouldTakeScreenshot = Expando<bool>();

  bool get shouldTakeScreenshot => _shouldTakeScreenshot[this] ?? false;
  set shouldTakeScreenshot(bool x) => _shouldTakeScreenshot[this] = x;

  Future<void> takeScreenshot(
    String name, {
    String directory = '../screenshots',
    Duration timeout = const Duration(seconds: 30),
    bool waitUntilNoTransientCallbacks = true,
  }) async {
    if (shouldTakeScreenshot && !File('../screenshots/$name.png').existsSync()) {
      await _takeScreenshot(
        name,
        directory: directory,
        timeout: timeout,
        waitUntilNoTransientCallbacks: waitUntilNoTransientCallbacks,
      );
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
    await requestData(RealAppTestCommand.devModeOff);
    final pixels = await screenshot();
    final directoryPath = directory.endsWith('/') ? directory : '$directory/';
    final file = await File('$directoryPath$name.png').create(recursive: true);
    await file.writeAsBytes(pixels);
    // ignore: avoid_print
    print('Screenshot $name created at ${file.path}');
  }
}
