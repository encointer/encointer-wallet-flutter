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

  void _responseTrueShowNotification(int i) {
    when(() => functions.showNotification(i, feeds[i].title, feeds[i].content)).thenAnswer((inc) async => true);
  }

  void _responseTrueCache() {
    when(() => functions.cache(lastList)).thenAnswer((i) async => true);
  }

  void _verifyShowNotification(int i) {
    verify(() => functions.showNotification(i, feeds[i].title, feeds[i].content)).called(1);
  }

  void _verifyCache() {
    verify(() => functions.cache(lastList)).called(1);
  }

  void _verifyNeverShowNotification(int i) {
    verifyNever(() => functions.showNotification(i, feeds[i].title, feeds[i].content));
  }

  test('notificationForLoop show notification 3, cache list=[]', () async {
    final list = <String>[];
    _responseTrueShowNotification(0);
    _responseTrueShowNotification(1);
    _responseTrueShowNotification(2);

    _responseTrueCache();

    await showAllNotificationsFromFeed(feeds, list, functions.showNotification, functions.cache);

    _verifyShowNotification(0);
    _verifyShowNotification(1);
    _verifyShowNotification(2);

    _verifyCache();
  });

  test('notificationForLoop show notification 2, cache list=["msg-1"]', () async {
    final list = <String>['msg-1'];
    _responseTrueShowNotification(1);
    _responseTrueShowNotification(2);

    _responseTrueCache();

    await showAllNotificationsFromFeed(feeds, list, functions.showNotification, functions.cache);

    _verifyNeverShowNotification(0);
    _verifyShowNotification(1);
    _verifyShowNotification(2);

    _verifyCache();
  });

  test('notificationForLoop show notification 1, cache list=["msg-1", "msg-2"]', () async {
    final list = <String>['msg-1', 'msg-2'];

    _responseTrueShowNotification(2);

    _responseTrueCache();

    await showAllNotificationsFromFeed(feeds, list, functions.showNotification, functions.cache);

    _verifyNeverShowNotification(0);
    _verifyNeverShowNotification(1);
    _verifyShowNotification(2);

    _verifyCache();
  });

  test('notificationForLoop show notification 0, cache list=["msg-1", "msg-2", "msg-3"]', () async {
    final list = <String>['msg-1', 'msg-2', 'msg-3'];

    await showAllNotificationsFromFeed(feeds, list, functions.showNotification, functions.cache);

    _verifyNeverShowNotification(0);
    _verifyNeverShowNotification(1);
    _verifyNeverShowNotification(2);

    verifyNever(() => functions.cache(lastList));
  });
}
