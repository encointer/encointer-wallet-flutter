import 'package:collection/collection.dart';
import 'package:ew_http/ew_http.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/service/meetup/feed_model.dart';

class NotificationHandler {
  static Future<void> fetchMessagesAndScheduleNotifications(
    tz.Location local,
    ScheduleNotification scheduleNotification, {
    required String langCode,
    String? cid,
    required EwHttp ewHttp,
    bool devMode = false,
  }) async {
    final feeds = await ewHttp.getTypeList(
      replaceLocalePlaceholder('${getEncointerFeedLink(devMode: devMode)}/$communityMessagesPath', langCode),
      fromJson: Feed.fromJson,
    );
    if (feeds != null && feeds.isNotEmpty) {
      feeds.forEachIndexed((i, e) async {
        if (tz.TZDateTime.from(feeds[i].showAt, local).isAfter(DateTime.now())) {
          await scheduleNotification(
            feeds[i].notificationId,
            feeds[i].title,
            feeds[i].content,
            tz.TZDateTime.from(feeds[i].showAt, local),
            cid: cid,
          );
        }
      });
    }
  }
}
