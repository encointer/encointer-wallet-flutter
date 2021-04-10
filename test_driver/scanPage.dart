import 'dart:io';

import 'package:encointer_wallet/mocks/scanPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();

  runApp(MaterialApp(
      title: 'EncointerWallet',
      initialRoute: MockScanPage.route,
      routes: {
        MockScanPage.route: (_) => MockScanPage(FileImage(File("test_driver/resources/encointer-receive-qr-1.jpg")))
      }
  ));
}
