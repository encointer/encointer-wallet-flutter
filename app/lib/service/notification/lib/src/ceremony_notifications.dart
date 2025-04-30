import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';

/// Manages meetups reminder notifications.
///
/// The notification IDs are derived from the ceremony index, so that we have a unique,
/// deterministic ID per reminder type per ceremony index.
class CeremonyNotifications {
  /// Schedules two meetup reminders for a registered meetup.
  static Future<void> scheduleMeetupReminders({
    required int ceremonyIndex,
    required int meetupTime,
    required AppLocalizations l10n,
    String? cid,
  }) async {
    final meetupDateTime = DateTime.fromMillisecondsSinceEpoch(meetupTime);

    final oneHourBeforeMeetup = meetupDateTime.subtract(const Duration(hours: 1));
    if (oneHourBeforeMeetup.isAfter(DateTime.now())) {
      await NotificationPlugin.scheduleNotification(
        Notification.oneHourBeforeMeetupReminder.id(ceremonyIndex),
        l10n.meetupNotificationOneHourBeforeTitle,
        l10n.meetupNotificationOneHourBeforeContent,
        oneHourBeforeMeetup,
        cid: cid,
      );
    }

    final oneDayBeforeMeetup = meetupDateTime.subtract(const Duration(days: 1));
    if (oneDayBeforeMeetup.isAfter(DateTime.now())) {
      await NotificationPlugin.scheduleNotification(
        Notification.oneDayBeforeMeetupReminder.id(ceremonyIndex),
        l10n.meetupNotificationOneDayBeforeTitle,
        l10n.meetupNotificationOneDayBeforeContent,
        oneDayBeforeMeetup,
        cid: cid,
      );
    }
  }

  /// Schedules notifications that the registering phase starts for the next [numberOfCyclesToSchedule] cycles.
  static Future<void> scheduleRegisteringStartsReminders(
    int nextRegisteringPhase,
    int currentCeremonyIndex,
    int ceremonyCycleDuration,
    AppLocalizations l10n, {
    int numberOfCyclesToSchedule = 5,
    String? cid,
  }) async {
    if (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(nextRegisteringPhase))) {
      // Doesn't happen except occasionally on first app startup. So we don't care about it.
      Log.e(
        '[CeremonyNotifications] nextRegisteringPhase is in the past: ${DateTime.fromMillisecondsSinceEpoch(nextRegisteringPhase)}',
      );
      return;
    }

    for (var i = 0; i < numberOfCyclesToSchedule; i++) {
      // calculate the scheduled date by adding i*ceremonyCycleDuration to nextRegisteringPhase
      final scheduledDate = DateTime.fromMillisecondsSinceEpoch(nextRegisteringPhase + i * ceremonyCycleDuration);
      await NotificationPlugin.scheduleNotification(
        Notification.registeringPhaseStarted.id(currentCeremonyIndex) + i,
        l10n.registeringPhaseReminderTitle,
        l10n.registeringPhaseReminderContent,
        scheduledDate,
        cid: cid,
      );
    }
  }

  /// Schedules notifications that the registering phase ends for the next [numberOfCyclesToSchedule] cycles.
  ///
  /// Shows the notification [showBeforeAssigningPhase] before the [assigningPhaseStart].
  static Future<void> scheduleLastDayOfRegisteringReminders(
    int assigningPhaseStart,
    int currentCeremonyIndex,
    int ceremonyCycleDuration,
    AppLocalizations l10n, {
    int numberOfCyclesToSchedule = 5,
    Duration showBeforeAssigningPhase = const Duration(hours: 24),
    String? cid,
  }) async {
    for (var i = 0; i < numberOfCyclesToSchedule; i++) {
      final scheduledDate = DateTime.fromMillisecondsSinceEpoch(assigningPhaseStart + i * ceremonyCycleDuration)
          .subtract(showBeforeAssigningPhase);

      if (scheduledDate.isAfter(DateTime.now())) {
        await NotificationPlugin.scheduleNotification(
          Notification.lastDayOfRegisteringReminder.id(currentCeremonyIndex) + i,
          l10n.registeringPhaseReminderTitle,
          l10n.registeringPhaseReminderContent,
          scheduledDate,
          cid: cid,
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
