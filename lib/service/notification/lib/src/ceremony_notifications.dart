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

  /// Schedules notifications that the registering phase starts for the next [numberOfCyclesToSchedule] cycles.
  static Future<void> scheduleRegisteringStartsReminders(
    int nextRegisteringPhase,
    int currentCeremonyIndex,
    int ceremonyCycleDuration,
    TranslationsEncointer dic, {
    int numberOfCyclesToSchedule = 5,
  }) async {
    for (var i = 0; i < numberOfCyclesToSchedule; i++) {
      // calculate the scheduled date by adding i*ceremonyCycleDuration to nextRegisteringPhase
      final scheduledDate = DateTime.fromMillisecondsSinceEpoch(nextRegisteringPhase + i * ceremonyCycleDuration);
      await NotificationPlugin.scheduleNotification(
        Notification.registeringPhaseStarted.id(currentCeremonyIndex) + i,
        dic.registeringPhaseReminderTitle,
        dic.registeringPhaseReminderContent,
        scheduledDate,
      );
    }
  }

  /// Schedules notifications that the registering phase ends for the next [numberOfCyclesToSchedule] cycles.
  ///
  /// Shows the notification [showBeforeAssigningPhaseHours] before the [assigningPhaseStart].
  static Future<void> scheduleLastDayOfRegisteringReminders(
    int assigningPhaseStart,
    int currentCeremonyIndex,
    int ceremonyCycleDuration,
    TranslationsEncointer dic, {
    int numberOfCyclesToSchedule = 5,
    int showBeforeAssigningPhaseHours = 24,
  }) async {
    for (var i = 0; i < numberOfCyclesToSchedule; i++) {
      // Scheduled date is 24 hours before the assigning phase starts.
      final scheduledDate = DateTime.fromMillisecondsSinceEpoch(assigningPhaseStart + i * ceremonyCycleDuration)
          .subtract(Duration(hours: showBeforeAssigningPhaseHours));

      if (scheduledDate.isAfter(DateTime.now())) {
        await NotificationPlugin.scheduleNotification(
          Notification.lastDayOfRegisteringReminder.id(currentCeremonyIndex) + i,
          dic.registeringPhaseReminderTitle,
          dic.registeringPhaseReminderContent,
          scheduledDate,
        );
      }
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
