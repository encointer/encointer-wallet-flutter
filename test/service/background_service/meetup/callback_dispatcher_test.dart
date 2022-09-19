import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:encointer_wallet/service/background_service/background_service.dart';

import '../../../fixtures/fixture_reader.dart';

class Functions {
  Future<bool> showNotification(int id, String title, String body) async {
    return Future.value(true);
  }

  Future<bool> cache(List<String> value) async {
    return Future.value(true);
  }
}

class MockFunctions extends Mock implements Functions {}

void main() async {
  final feeds = feedFromJson(fixture('feed_list'));
  final list = <String>['msg-1', 'msg-2'];
  final lastList = <String>['msg-1', 'msg-2', 'msg-3'];

  final functions = MockFunctions();

  test('notificationForLoop', () async {
    when(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).thenAnswer((i) async => true);
    when(() => functions.cache(lastList)).thenAnswer((i) async => true);

    await notificationForLoop(feeds, list, functions.showNotification, functions.cache);

    verify(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).called(1);
    verify(() => functions.cache(lastList)).called(1);
  });
}
