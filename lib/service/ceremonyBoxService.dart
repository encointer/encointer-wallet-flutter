import 'package:intl/intl.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

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

  static bool shouldShowRegisterButton(CeremonyPhase currentPhase, bool isRegistered) {
    return (currentPhase == CeremonyPhase.register && !isRegistered);
  }

  static bool shouldShowStartCeremonyButton(CeremonyPhase currentPhase, bool isRegistered) {
    return (currentPhase == CeremonyPhase.attest && isRegistered);
  }

  static CeremonyPhase getCurrentPhase(DateTime registerUntilDate, DateTime nextCeremonyDate) {
    DateTime now = DateTime.now();
    if (now.compareTo(registerUntilDate) < 0) return CeremonyPhase.register;
    if (now.compareTo(nextCeremonyDate) > 0) return CeremonyPhase.attest;
    return CeremonyPhase.assign;
  }

  /// for rendering the progress consider the following assumptions:
  /// reg phase: nextCeremonyDate.subtract(Duration(days: 41)) until registerUntilDate
  /// assign phase: registerUntilDate until nextCeremonyDate
  /// ceremony phase: nextCeremonyDate until 30min later
  /// arbitrarily use a 128 division, as I have to use integers
  static int getProgressElapsed(DateTime registerUntilDate, DateTime nextCeremonyDate, CeremonyPhase currentPhase,
      int phase1register, int phase2assign, int phase3attest) {
    DateTime now = DateTime.now();
    DateTime lastCeremonyDate = nextCeremonyDate.subtract(Duration(days: 41));
    Duration entirePhase;
    Duration elapsedPart;
    int phaseLengthCoarse;
    int subdivisions = 16;
    int pastPhasesOffset = 0;
    int totalSubdivisions = subdivisions * (phase1register + phase2assign + phase3attest);
    switch (currentPhase) {
      case (CeremonyPhase.register):
        entirePhase = registerUntilDate.difference(lastCeremonyDate);
        elapsedPart = now.difference(lastCeremonyDate);
        phaseLengthCoarse = phase1register;
        break;
      case (CeremonyPhase.assign):
        entirePhase = nextCeremonyDate.difference(registerUntilDate);
        elapsedPart = now.difference(registerUntilDate);
        phaseLengthCoarse = phase2assign;
        pastPhasesOffset = phase1register;
        break;
      case (CeremonyPhase.attest):
        entirePhase = Duration(minutes: 30); // arbitrarily defined
        elapsedPart = now.difference(nextCeremonyDate);
        phaseLengthCoarse = phase3attest;
        pastPhasesOffset = phase1register + phase2assign;
        break;
    }
    int timeElapsed = pastPhasesOffset * subdivisions +
        (phaseLengthCoarse * subdivisions * elapsedPart.inSeconds / entirePhase.inSeconds).round();
    return timeElapsed < totalSubdivisions ? timeElapsed : totalSubdivisions;
  }
}

enum CeremonyPhase {
  register,
  assign,
  attest,
}
