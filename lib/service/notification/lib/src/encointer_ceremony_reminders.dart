import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/utils/translations/translations_encointer.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';

const int oneHourBeforeMeetupReminderOffset = 1000000; // one million
const int oneDayBeforeMeetupReminderOffset = 2000000; // two millions

/// Schedules two meetup reminders for a registered meetup.
Future<void> scheduleMeetupReminderNotifications(int ceremonyIndex, int meetupTime, TranslationsEncointer dic) async {
  final meetupDateTime = DateTime.fromMillisecondsSinceEpoch(meetupTime);
  final beforeOneHour = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(hours: 1)), tz.local);
  final beforeOneDay = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(days: 1)), tz.local);
  if (beforeOneHour.isAfter(DateTime.now())) {
    await NotificationPlugin.scheduleNotification(
      ceremonyIndex + oneHourBeforeMeetupReminderOffset,
      dic.meetupNotificationOneHourBeforeTitle,
      dic.meetupNotificationOneHourBeforeContent,
      beforeOneHour,
    );
  }
  if (beforeOneDay.isAfter(DateTime.now())) {
    await NotificationPlugin.scheduleNotification(
      ceremonyIndex + oneDayBeforeMeetupReminderOffset,
      dic.meetupNotificationOneDayBeforeTitle,
      dic.meetupNotificationOneDayBeforeContent,
      beforeOneDay,
    );
  }
}
