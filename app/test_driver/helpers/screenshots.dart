import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';

Future<void> takeScreenshot(
  FlutterDriver driver,
  String name, {
  String directory = '../screenshots',
  Duration timeout = const Duration(seconds: 30),
  bool waitUntilNoTransientCallbacks = true,
}) async {
  if (waitUntilNoTransientCallbacks) {
    await driver.waitUntilNoTransientCallbacks(timeout: timeout);
  }

  final pixels = await driver.screenshot();
  final directoryPath = directory.endsWith('/') ? directory : '$directory/';
  final file = await File('$directoryPath$name.png').create(recursive: true);
  await file.writeAsBytes(pixels);
  // ignore: avoid_print
  print('Screenshot $name created at ${file.path}');
}
