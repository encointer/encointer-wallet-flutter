import 'dart:convert';

import 'package:encointer_wallet/mocks/restartWidget.dart';
import 'package:encointer_wallet/mocks/scanPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  final PublishSubject<ImageProvider> stream = PublishSubject();

  // ignore: missing_return
  Future<String> dataHandler(String msg) async {
    final img = MemoryImage(base64Decode(msg));
    stream.add(img);
  }

  enableFlutterDriverExtension(handler: dataHandler);

  runApp(
    MaterialApp(
      title: 'EncointerWallet',
      initialRoute: MockScanPage.route,
      routes: {
        MockScanPage.route: (_) => RestartWidget(
              initialData: MemoryImage(base64Decode("hell")),
              stream: stream,
              builder: (_, img) => MockScanPage(img),
            )
      },
    ),
  );
}
