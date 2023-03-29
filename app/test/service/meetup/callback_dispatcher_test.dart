import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/meetup/meetup.dart';

class MockLocation extends Mock implements tz.Location {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final local = MockLocation();
  Future<void> mockScheduleNotification(
    int id,
    String title,
    String body,
    tz.TZDateTime scheduledDate, {
    String? cid,
  }) async {}

  const channel = MethodChannel('flutter_timezone');

  setUp(() => channel.setMockMethodCallHandler((MethodCall methodCall) async => '42'));

  test('executeTaskIsolate called', () async {
    await NotificationHandler.fetchMessagesAndScheduleNotifications(local, mockScheduleNotification, 'en', 'leo');
  });
}
