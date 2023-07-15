import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> changeLanguage(FlutterDriver driver) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.settingsLanguage));
  await driver.tap(find.byValueKey(EWTestKeys.settingsLanguage));
  await driver.waitFor(find.text('Language'));
  await driver.tap(find.byValueKey('locale-de'));
  await driver.waitFor(find.text('Sprache'));
  await driver.tap(find.byValueKey('locale-fr'));
  await driver.waitFor(find.text('Langue'));
  await driver.tap(find.byValueKey('locale-ru'));
  await driver.waitFor(find.text('Язык'));
  await driver.tap(find.byValueKey('locale-en'));
  await driver.waitFor(find.text('Language'));
  await driver.tap(find.pageBack());
}
