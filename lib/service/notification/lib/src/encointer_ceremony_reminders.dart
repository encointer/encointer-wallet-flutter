import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/utils/translations/translations_encointer.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';

Future<void> scheduleMeetupReminderNotifications(int notificationId, int meetupTime, TranslationsEncointer dic) async {
  final meetupDateTime = DateTime.fromMillisecondsSinceEpoch(meetupTime);
  final beforeOneHour = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(hours: 1)), tz.local);
  final beforeOneDay = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(days: 1)), tz.local);
  if (beforeOneHour.isAfter(DateTime.now())) {
    await NotificationPlugin.scheduleNotification(
      notificationId,
      dic.meetupNotificationOneHourBeforeTitle,
      dic.meetupNotificationOneHourBeforeContent,
      beforeOneHour,
    );
  }
  if (beforeOneDay.isAfter(DateTime.now())) {
    await NotificationPlugin.scheduleNotification(
      24 + notificationId,
      dic.meetupNotificationOneDayBeforeTitle,
      dic.meetupNotificationOneDayBeforeContent,
      beforeOneDay,
    );
  }
}
