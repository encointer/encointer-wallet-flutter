import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/l10n/l10.dart';

/// stateless service that computes some of the view logic of the ceremony box
class CeremonyBoxService {
  /// Returns a formatted date yMd or tomorrow or today
  static String formatYearMonthDay(DateTime input, AppLocalizations l10n, String? languageCode) {
    if (isToday(input)) {
      return l10n.today;
    }
    if (isTomorrow(input)) {
      return l10n.tomorrow;
    }
    return DateFormat.yMd(languageCode).format(input);
  }

  static String formatDayRelative(DateTime nextCeremonyDate, AppLocalizations l10n, String? languageCode) {
    if (isToday(nextCeremonyDate)) {
      return l10n.today;
    }
    if (isTomorrow(nextCeremonyDate)) {
      return l10n.tomorrow;
    }

    final timeLeftUntilCeremonyStarts = nextCeremonyDate.difference(DateTime.now());
    return '${timeLeftUntilCeremonyStarts.inDays}d';
  }

  static bool isToday(DateTime input) {
    return DateFormat.yMd().format(DateTime.now()) == DateFormat.yMd().format(input);
  }

  static bool isTomorrow(DateTime input) {
    return DateFormat.yMd().format(DateTime.now().add(const Duration(days: 1))) == DateFormat.yMd().format(input);
  }

  /// Returns a formatted string of days and hours till ceremony starts
  static String ddHHUntilCeremony(DateTime nextCeremonyDate) {
    final timeLeftUntilCeremonyStarts = nextCeremonyDate.difference(DateTime.now());
    return '${timeLeftUntilCeremonyStarts.inDays}d ${timeLeftUntilCeremonyStarts.inHours.remainder(24)}h';
  }

  /// Returns a formatted string of days
  static String ddUntilCeremony(DateTime nextCeremonyDate) {
    final timeLeftUntilCeremonyStarts = nextCeremonyDate.difference(DateTime.now());
    return '${timeLeftUntilCeremonyStarts.inDays}d';
  }

  /// If it is close to the ceremony show a countdown
  static bool shouldShowCountdown(DateTime nextCeremonyDate) {
    final timeLeftUntilCeremonyStarts = nextCeremonyDate.difference(DateTime.now());
    return timeLeftUntilCeremonyStarts.compareTo(const Duration(days: 2)) < 0;
  }

  static Event createCalendarEvent(DateTime nextCeremonyDate, AppLocalizations l10n) {
    return Event(
      title: l10n.keySigningCycle,
      description: l10n.calendarEntryDescription,
      location: 'yet unknown',
      startDate: nextCeremonyDate,
      endDate: nextCeremonyDate.add(const Duration(minutes: 60)),
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
      ),
      // androidParams: AndroidParams(
      //   emailInvites: ["test@example.com"],
      // ),
      // recurrence: recurrence,
    );
  }

  static bool showAddToCalendarIconButton() {
    // TODO
    return true;
  }

  /// Gets the ceremony progress as a fraction
  static double? getProgressElapsed(
    int currentTime,
    int assigningStart,
    int? meetupTime,
    Map<CeremonyPhase, int> ceremonyPhaseDurations,
    double registerFlex,
    double assigningFlex,
    double attestingFlex,
  ) {
    final totalFlex = registerFlex + assigningFlex + attestingFlex;
    final ceremonyStart = assigningStart - ceremonyPhaseDurations[CeremonyPhase.Registering]!;

    if (currentTime < ceremonyStart) {
      throw Exception('[CeremonyProgressBar] Current time was smaller than ceremony start');
    }

    double? progressUnormalized;

    if (currentTime < assigningStart) {
      progressUnormalized =
          (currentTime - ceremonyStart) / ceremonyPhaseDurations[CeremonyPhase.Registering]! * registerFlex;
    } else if (currentTime < meetupTime!) {
      progressUnormalized = registerFlex +
          (currentTime - assigningStart) / ceremonyPhaseDurations[CeremonyPhase.Assigning]! * assigningFlex;
    } else {
      progressUnormalized = registerFlex +
          assigningFlex +
          (currentTime - meetupTime) / ceremonyPhaseDurations[CeremonyPhase.Attesting]! * attestingFlex;
    }

    return progressUnormalized / totalFlex;
  }
}
