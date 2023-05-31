import 'package:ew_http/ew_http.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/meetup/feed_model.dart';
import 'package:encointer_wallet/service/log/log_service.dart';

class NotificationHandler {
  static Future<void> fetchMessagesAndScheduleNotifications(
    tz.Location local,
    ScheduleNotification scheduleNotification, {
    required String langCode,
    String? cid,
    required EwHttp ewHttp,
  }) async {
    final response = await ewHttp.getTypeList(
      replaceLocalePlaceholder(meetupNotificationLink, langCode),
      fromJson: Feed.fromJson,
    );

    response.fold((l) => Log.e(l.toString()), (r) async {
      for (final e in r) {
        if (tz.TZDateTime.from(e.showAt, local).isAfter(DateTime.now())) {
          await scheduleNotification(
            e.notificationId,
            e.title,
            e.content,
            tz.TZDateTime.from(e.showAt, local),
            cid: cid,
          );
        }
      }
    });
  }
}
