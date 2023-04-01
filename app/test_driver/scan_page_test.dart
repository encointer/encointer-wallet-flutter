import 'dart:convert';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'package:encointer_wallet/utils/screenshot.dart';

void main() {
  FlutterDriver? driver;
  final config = Config();

  group('scan-page', () {
    setUpAll(() async {
      driver = await FlutterDriver.connect();

      // waits until the firs frame after ft startup stabilized
      await driver!.waitUntilFirstFrameRasterized();
    });

    test('scan-page-screenshot', () async {
      final file = File('test_driver/resources/encointer-receive-qr-1.jpg');
      final bytes = await file.readAsBytes();
      final base64 = base64Encode(bytes);

      // set the background in the MockScanPage
      await driver!.requestData(base64);

      await screenshot(driver!, config, 'scan-receive');
    });
  });
  tearDownAll(() async {
    if (driver != null) {
      await driver!.close();
    }
  });
}
