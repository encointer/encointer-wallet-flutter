import 'package:encointer_wallet/utils/translations/translations_encointer.dart';
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

  /// This method schedules reminders for ceremonies that will occur in a certain period of time.
  static Future<void> scheduleRegisteringReminders(
    int nextRegisteringPhase,
    int currentCeremonyIndex,
    int ceremonyCycleDuration,
    TranslationsEncointer dic,
  ) async {
    for (var i = 0; i < 10; i++) {
      // calculate the scheduled date by adding i*ceremonyCycleDuration to nextRegisteringPhase
      final scheduledDate = DateTime.fromMillisecondsSinceEpoch(nextRegisteringPhase + i * ceremonyCycleDuration);
      await NotificationPlugin.scheduleNotification(
        currentCeremonyIndex + i,
        dic.registeringPhaseReminderTitle,
        dic.registeringPhaseReminderContent,
        scheduledDate,
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
