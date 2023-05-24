import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:rxdart/rxdart.dart';

part 'scan_page/mock_qr_scan_page.dart';

/// Here we start the MockScanPage first with some random background. Afterwards we send the encoded background image
/// from the driver to the app.
///
/// Reasoning behind that procedure is that we don't want to include the high resolution image that we set as
/// background in the app bundle. Flutter does not yet support build configuration /-flavor dependant asset inclusion.
void main() async {
  final stream = PublishSubject<ImageProvider>();

  Future<String> dataHandler(String? msg) async {
    final img = MemoryImage(base64Decode(msg!));
    stream.add(img);
    // to fix static analysis
    return 'DataHandler';
  }

  enableFlutterDriverExtension(handler: dataHandler);
  WidgetsApp.debugAllowBannerOverride = false;

  runApp(
    MaterialApp(
      home: RestartWidget(
        initialData: MemoryImage(base64Decode('hell')),
        stream: stream,
        builder: (_, ImageProvider<Object> img) => MockQRScanPage(img),
      ),
    ),
  );
}
