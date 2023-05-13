import 'package:flutter_driver/flutter_driver.dart';

Future<void> turnDevMode(FlutterDriver driver) async {
  await driver.tap(find.byValueKey('dev-mode'));
}
