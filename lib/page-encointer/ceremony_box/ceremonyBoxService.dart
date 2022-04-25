import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:intl/intl.dart';

import '../../models/index.dart';

/// stateless service that computes some of the view logic of the ceremony box
class CeremonyBoxService {
  /// Returns a formatted date yMd or tomorrow or today
  static String formatYearMonthDay(DateTime input, Translations dic, String languageCode) {
    String formatted = '${DateFormat.yMd(languageCode).format(input)}';
    String todayYearMonthDay = DateFormat.yMd(languageCode).format(DateTime.now());
    String tomorrowYearMonthDay = DateFormat.yMd(languageCode).format(DateTime.now().add(Duration(days: 1)));
    bool ceremonyIsToday = (formatted == todayYearMonthDay);
    if (ceremonyIsToday) {
      formatted = '${dic.encointer.today}';
    }
    if (formatted == tomorrowYearMonthDay) {
      formatted = '${dic.encointer.tomorrow}';
    }
    return formatted;
  }

  /// Returns a formatted string of days and hours till ceremony starts
  static String getTimeLeftUntilCeremonyStartsDaysHours(DateTime nextCeremonyDate) {
    Duration timeLeftUntilCeremonyStarts = nextCeremonyDate.difference(DateTime.now());
    return '${timeLeftUntilCeremonyStarts.inDays}d ${timeLeftUntilCeremonyStarts.inHours.remainder(24)}h';
  }

  /// If it is close to the ceremony show a countdown
  static bool shouldShowCountdown(DateTime nextCeremonyDate) {
    Duration timeLeftUntilCeremonyStarts = nextCeremonyDate.difference(DateTime.now());
    return (timeLeftUntilCeremonyStarts.compareTo(Duration(days: 2)) < 0);
  }

  static Event createCalendarEvent(DateTime nextCeremonyDate, Translations dic) {
    return Event(
      title: dic.encointer.encointerCeremony,
      description: dic.encointer.calendarEntryDescription,
      location: 'yet unknown',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
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
  static double getProgressElapsed(
    int currentTime,
    int assigningStart,
    Map<CeremonyPhase, int> ceremonyPhaseDurations,
  ) {
    var totalCeremonyTime = ceremonyPhaseDurations.values.reduce((sum, duration) => sum + duration);
    var ceremonyStart = assigningStart - ceremonyPhaseDurations[CeremonyPhase.Registering];

    return (currentTime - ceremonyStart) / totalCeremonyTime;
  }
}
