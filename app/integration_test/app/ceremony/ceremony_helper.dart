import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/wait_helpers.dart';

Future<void> enterAttendeesCount(WidgetTester tester, int participantsCount) async {
  await waitForWidget(tester, find.byKey(const Key(EWTestKeys.attendeesCount)));
  await tester.tap(find.byKey(const Key(EWTestKeys.attendeesCount)));
  await tester.pumpAndSettle();
  await tester.enterText(find.byKey(const Key(EWTestKeys.attendeesCount)), '$participantsCount');
  await tester.pumpAndSettle();
}
