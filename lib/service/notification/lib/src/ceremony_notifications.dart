import 'package:translation/translation.dart';

import 'package:encointer_wallet/service/notification/lib/notification.dart';

/// Manages meetups reminder notifications.
///
/// The notification IDs are derived from the ceremony index, so that we have a unique,
/// deterministic ID per reminder type per ceremony index.
class CeremonyNotifications {
  /// Schedules two meetup reminders for a registered meetup.
  static Future<void> scheduleMeetupReminders(int ceremonyIndex, int meetupTime, TranslationsEncointer dic) async {
    final meetupDateTime = DateTime.fromMillisecondsSinceEpoch(meetupTime);

    final oneHourBeforeMeetup = meetupDateTime.subtract(const Duration(hours: 1));
    if (oneHourBeforeMeetup.isAfter(DateTime.now())) {
      await NotificationPlugin.scheduleNotification(
        Notification.oneHourBeforeMeetupReminder.id(ceremonyIndex),
        dic.meetupNotificationOneHourBeforeTitle,
        dic.meetupNotificationOneHourBeforeContent,
        oneHourBeforeMeetup,
      );
    }

    final oneDayBeforeMeetup = meetupDateTime.subtract(const Duration(days: 1));
    if (oneDayBeforeMeetup.isAfter(DateTime.now())) {
      await NotificationPlugin.scheduleNotification(
        Notification.oneDayBeforeMeetupReminder.id(ceremonyIndex),
        dic.meetupNotificationOneDayBeforeTitle,
        dic.meetupNotificationOneDayBeforeContent,
        oneDayBeforeMeetup,
      );
    }
  }
}

/// Handles notification IDs for different notification categories.
enum Notification {
  /// Notification when the registering phase starts.
  registeringPhaseStarted(1000000),

  /// Reminder that the registering phase ends this day.
  lastDayOfRegisteringReminder(2000000),

  /// Reminder to be displayed one day before the meetup.
  oneDayBeforeMeetupReminder(300000),

  /// Notification to be displayed one hour before the meetup.
  oneHourBeforeMeetupReminder(4000000);

  const Notification(this.offset);

  /// The difference between these offsets should be big enough, so that we can ensure
  /// that we can schedule enough notifications for each notification category.
  final int offset;

  int id(int ceremonyIndex) => ceremonyIndex + offset;
}
