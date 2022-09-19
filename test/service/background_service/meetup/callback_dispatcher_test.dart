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
  final lastList = <String>['msg-1', 'msg-2', 'msg-3'];

  final functions = MockFunctions();

  test('notificationForLoop show notification 3, cache list=[]', () async {
    final list = <String>[];
    when(() => functions.showNotification(0, feeds[0].title, feeds[0].content)).thenAnswer((i) async => true);
    when(() => functions.showNotification(1, feeds[1].title, feeds[1].content)).thenAnswer((i) async => true);
    when(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).thenAnswer((i) async => true);

    when(() => functions.cache(lastList)).thenAnswer((i) async => true);

    await notificationForLoop(feeds, list, functions.showNotification, functions.cache);

    verify(() => functions.showNotification(0, feeds[0].title, feeds[0].content)).called(1);
    verify(() => functions.showNotification(1, feeds[1].title, feeds[1].content)).called(1);
    verify(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).called(1);

    verify(() => functions.cache(lastList)).called(1);
  });

  test('notificationForLoop show notification 2, cache list=["msg-1"]', () async {
    final list = <String>['msg-1'];
    when(() => functions.showNotification(1, feeds[1].title, feeds[1].content)).thenAnswer((i) async => true);
    when(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).thenAnswer((i) async => true);

    when(() => functions.cache(lastList)).thenAnswer((i) async => true);

    await notificationForLoop(feeds, list, functions.showNotification, functions.cache);

    verifyNever(() => functions.showNotification(0, feeds[0].title, feeds[0].content));
    verify(() => functions.showNotification(1, feeds[1].title, feeds[1].content)).called(1);
    verify(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).called(1);

    verify(() => functions.cache(lastList)).called(1);
  });

  test('notificationForLoop show notification 1, cache list=["msg-1", "msg-2"]', () async {
    final list = <String>['msg-1', 'msg-2'];

    when(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).thenAnswer((i) async => true);

    when(() => functions.cache(lastList)).thenAnswer((i) async => true);

    await notificationForLoop(feeds, list, functions.showNotification, functions.cache);

    verifyNever(() => functions.showNotification(0, feeds[0].title, feeds[0].content));
    verifyNever(() => functions.showNotification(1, feeds[1].title, feeds[1].content));
    verify(() => functions.showNotification(2, feeds[2].title, feeds[2].content)).called(1);

    verify(() => functions.cache(lastList)).called(1);
  });

  test('notificationForLoop show notification 0, cache list=["msg-1", "msg-2", "msg-3"]', () async {
    final list = <String>['msg-1', 'msg-2', 'msg-3'];

    await notificationForLoop(feeds, list, functions.showNotification, functions.cache);

    verifyNever(() => functions.showNotification(0, feeds[0].title, feeds[0].content));
    verifyNever(() => functions.showNotification(1, feeds[1].title, feeds[1].content));
    verifyNever(() => functions.showNotification(2, feeds[2].title, feeds[2].content));

    verifyNever(() => functions.cache(lastList));
  });
}
