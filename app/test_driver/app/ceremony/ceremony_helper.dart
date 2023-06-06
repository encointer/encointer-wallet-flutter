import 'package:flutter_driver/flutter_driver.dart';

Future<void> enterAttendeesCount(FlutterDriver driver, int participantsCount) async {
  await driver.waitFor(find.byValueKey('attendees-count'));
  await driver.tap(find.byValueKey('attendees-count'));
  await driver.enterText('$participantsCount');
}
