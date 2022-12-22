import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_repo.dart';

typedef ScheduleNotificationFunction = Future<void> Function(
    int id, String title, String body, tz.TZDateTime scheduledDate);

Future<void> executeTaskIsolate(Map<String, dynamic> inputData) async {
  await _executeTask(inputData);
}

Future<bool> _executeTask(Map<String, dynamic> inputData) async {
  final langCode = inputData['langCode'] as String;
  final local = inputData['local'] as tz.Location;
  final scheduleNotification = inputData['scheduleNotification'] as ScheduleNotificationFunction;

  final _feeds = await FeedRepo().fetchData(langCode);

  if (_feeds != null) await showAllNotificationsFromFeed(_feeds, local, scheduleNotification);

  return Future.value(true);
}

Future<void> showAllNotificationsFromFeed(
  List<Feed> feeds,
  tz.Location local,
  ScheduleNotificationFunction scheduleNotification,
) async {
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
}
