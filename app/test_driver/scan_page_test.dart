import 'dart:convert';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'helpers/helper.dart';

void main() {
  late FlutterDriver driver;
  const receiveQrImagePath = 'test_driver/scan_page/encointer-receive-qr-1.jpg';

  setUpAll(() async {
    driver = await FlutterDriver.connect();
    await driver.waitUntilFirstFrameRasterized();
  });

  test('scan-page-screenshot', () async {
    final file = File(receiveQrImagePath);
    final bytes = await file.readAsBytes();
    final base64 = base64Encode(bytes);

    // set the background in the MockScanPage
    await driver.requestData(base64);
    await driver.takeLocalScreenshot('mock-scan-receive');
  });

  tearDownAll(() async => driver.close());
}
