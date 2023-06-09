import 'package:ew_http/ew_http.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/config/prod_community.dart';
import 'package:encointer_wallet/service/meetup/meetup.dart';

class MockLocation extends Mock implements tz.Location {}

class MockEwHttp extends Mock implements EwHttp {
  @override
  Future<Either<List<T>, EwHttpException>> getTypeList<T>(String url, {required FromJson<T> fromJson}) async {
    return Right<List<T>, EwHttpException>(const []);
  }
}

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
    await NotificationHandler.fetchMessagesAndScheduleNotifications(
      local,
      mockScheduleNotification,
      langCode: 'en',
      cid: Cids.leuKsm,
      ewHttp: MockEwHttp(),
      devMode: true,
    );
  });
}
