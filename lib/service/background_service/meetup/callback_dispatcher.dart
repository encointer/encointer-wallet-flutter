import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/background_service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/background_service/meetup/feed_repo.dart';
import 'package:encointer_wallet/service/notification.dart';

class MeetupNotification {
  static Future<void> executeTaskIsolate(
    tz.Location local,
    ScheduleNotification scheduleNotification,
    String langCode,
  ) async {
    final _feeds = await compute(FeedRepo().fetchData, langCode);
    if (_feeds != null) await registerScheduleNotifications(_feeds, local, scheduleNotification);
  }

  static Future<void> registerScheduleNotifications(
    List<Feed> feeds,
    tz.Location local,
    ScheduleNotification scheduleNotification,
  ) async {
    feeds.forEachIndexed((i, e) async {
      if (tz.TZDateTime.from(feeds[i].showAt, local).isAfter(DateTime.now())) {
        await scheduleNotification(
          i + 100,
          feeds[i].title,
          '${feeds[i].content} showAt ${tz.TZDateTime.from(feeds[i].showAt, local)}',
          tz.TZDateTime.from(feeds[i].showAt, local),
        );
      }
    });
  }
}
