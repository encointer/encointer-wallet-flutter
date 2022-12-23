import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/background_service/background_service.dart';


class Functions {
  Future<bool> showNotification(int id, String title, String body) async {
    return Future.value(true);
  }

  Future<bool> cache(List<String> value) async {
    return Future.value(true);
  }
}

class MockFunctions extends Mock implements Functions {}

class MockLocation extends Mock implements tz.Location {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final local = MockLocation();
  Future<void> mockScheduleNotification(int id, String title, String body, tz.TZDateTime scheduledDate) async {}

  const channel = MethodChannel('flutter_timezone');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  test('notificationForLoop show notification 3, cache list=[]', () async {
    await MeetupNotification.executeTaskIsolate(
      local,
      mockScheduleNotification,
      'en',
    );
  });
}
