import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_repo.dart';

Future<void> executeTaskIsolate(dynamic message) async {
  final inputData = message as Map<String, dynamic>;
  await _executeTask(inputData);
}

Future<bool> _executeTask(Map<String, dynamic> inputData) async {
  final langCode = inputData['langCode'] as String;
  final local = inputData['local'] as tz.Location;

  final scheduleNotification = inputData['scheduleNotification'] as Future<void> Function(
      int id, String title, String body, tz.TZDateTime scheduledDate);
  final repository = FeedRepo();

  final _feeds = await repository.fetchData(langCode);

  if (_feeds == null) {
    Log.d('The result of the feed is null', 'callbackDispatcher');
    return Future.value(true);
  }

  await showAllNotificationsFromFeed(_feeds, local: local, scheduleNotification: scheduleNotification);

  return Future.value(true);
}

Future<List<String>> showAllNotificationsFromFeed(
  List<Feed> feeds, {
  required tz.Location local,
  required Future<void> Function(int id, String title, String body, tz.TZDateTime scheduledDate) scheduleNotification,
}) async {
  final shownNotifications = <String>[];

  for (var i = 0; i < feeds.length; i++) {
    if (tz.TZDateTime.from(feeds[i].showAt, local).isAfter(DateTime.now())) {
      await scheduleNotification(
        i,
        feeds[i].title,
        '${feeds[i].content} showAt ${tz.TZDateTime.from(feeds[i].showAt, local)}',
        tz.TZDateTime.from(feeds[i].showAt, local),
      );
    }
    if (tz.TZDateTime.from(feeds[i].meetupAt, local).isAfter(DateTime.now())) {
      await scheduleNotification(
        i + 100,
        feeds[i].title,
        '${feeds[i].content} meetupAt ${tz.TZDateTime.from(feeds[i].meetupAt, local)}',
        tz.TZDateTime.from(feeds[i].meetupAt, local),
      );
    }
  }
  return shownNotifications;
}
