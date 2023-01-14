import 'package:timezone/timezone.dart' as tz;

import 'package:encointer_wallet/utils/translations/translations_encointer.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';

// The difference between these offsets should be big enough, so that we can ensure
// that we can schedule enough notification for each notification category.
// const int registeringForMeetupReminderOffset = 1000000; // one million
const int oneHourBeforeMeetupReminderOffset = 2000000; // two millions
const int oneDayBeforeMeetupReminderOffset = 3000000; // three millions

/// Manages meetups reminder notifications.
///
/// The notification IDs are derived from the ceremony index, so that we have a unique,
/// deterministic ID per reminder type per ceremony index.
class CeremonyNotifications {
  /// Schedules two meetup reminders for a registered meetup.
  static Future<void> scheduleMeetupReminders(int ceremonyIndex, int meetupTime, TranslationsEncointer dic) async {
    final meetupDateTime = DateTime.fromMillisecondsSinceEpoch(meetupTime);

    final oneHourBeforeMeetup = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(hours: 1)), tz.local);
    if (oneHourBeforeMeetup.isAfter(DateTime.now())) {
      await NotificationPlugin.scheduleNotification(
        ceremonyIndex + oneHourBeforeMeetupReminderOffset,
        dic.meetupNotificationOneHourBeforeTitle,
        dic.meetupNotificationOneHourBeforeContent,
        oneHourBeforeMeetup,
      );
    }

    final oneDayBeforeMeetup = tz.TZDateTime.from(meetupDateTime.subtract(const Duration(days: 1)), tz.local);
    if (oneDayBeforeMeetup.isAfter(DateTime.now())) {
      await NotificationPlugin.scheduleNotification(
        ceremonyIndex + oneDayBeforeMeetupReminderOffset,
        dic.meetupNotificationOneDayBeforeTitle,
        dic.meetupNotificationOneDayBeforeContent,
        oneDayBeforeMeetup,
      );
    }
  }
}
