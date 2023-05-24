import 'package:flutter_driver/flutter_driver.dart';

Future<void> changeDevNetwork(FlutterDriver driver, String account) async {
  await driver.waitFor(find.byValueKey('nctr-gsl-dev'));
  await driver.tap(find.byValueKey('nctr-gsl-dev'));
  await driver.tap(find.text(account));
  await driver.waitFor(find.byValueKey('profile-list-view'));
  await driver.tap(find.byValueKey('dev-mode'));
}
