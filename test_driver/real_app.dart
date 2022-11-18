import 'package:flutter_driver/driver_extension.dart';
import 'package:upgrader/upgrader.dart';

import 'package:encointer_wallet/main.dart' as app;

void main() async {
  enableFlutterDriverExtension();
  final _appcastURL = 'https://encointer.github.io/feed/app_cast/testappcast.xml';
  final _cfg = AppcastConfiguration(url: _appcastURL, supportedOS: ['android']);
  await app.main(appCast: _cfg);
}
