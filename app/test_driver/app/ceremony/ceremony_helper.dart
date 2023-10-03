import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterAttendeesCount(FlutterDriver driver, int participantsCount) async {
  await driver.waitFor(find.byValueKey(EWTestKeys.attendeesCount));
  await driver.tap(find.byValueKey(EWTestKeys.attendeesCount));
  await driver.enterText('$participantsCount');
}
