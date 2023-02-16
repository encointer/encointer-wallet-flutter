import 'package:mobx/mobx.dart';

part 'opening_hours_state.g.dart';

// ignore: library_private_types_in_public_api
class OpeningHoursState = _OpeningHoursState with _$OpeningHoursState;

abstract class _OpeningHoursState with Store {
  _OpeningHoursState(this.mon, this.tue, this.wed, this.thu, this.fri, this.sat, this.sun);

  /// 0 -> Mon, 1 -> Tue, ... 6 -> Sun

  @observable
  OpeningHoursForDayState mon;
  @observable
  OpeningHoursForDayState tue;
  @observable
  OpeningHoursForDayState wed;
  @observable
  OpeningHoursForDayState thu;
  @observable
  OpeningHoursForDayState fri;
  @observable
  OpeningHoursForDayState sat;
  @observable
  OpeningHoursForDayState sun;

  @observable
  OpeningHoursForDayState? copiedOpeningHours;

  @observable
  int? dayOnFocus;

  @observable
  int? dayToCopyFrom;

  @action
  void copyFrom(int day) {
    if (day == dayToCopyFrom) {
      // tapping the same button again turns copying off and clears clipboard
      dayToCopyFrom = null;
      copiedOpeningHours = null;
    } else {
      dayToCopyFrom = day;
      copiedOpeningHours = getOpeningHoursFor(day);
    }
  }

  @action
  void setDayOnFocus(int day) {
    if (day == dayOnFocus) {
      // turn editing off again
      dayOnFocus = null;
    } else {
      dayOnFocus = day;
    }
  }

  @action
  void pasteOpeningHoursTo(int day) {
    final target = getOpeningHoursFor(day);
    if (copiedOpeningHours == null) return;

    for (final interval in copiedOpeningHours!.openingIntervals) {
      target!.addInterval(interval);
    }
  }

  // generic getter
  OpeningHoursForDayState? getOpeningHoursFor(int day) {
    switch (day) {
      case 0:
        return mon;
      case 1:
        return tue;
      case 2:
        return wed;
      case 3:
        return thu;
      case 4:
        return fri;
      case 5:
        return sat;
      case 6:
        return sun;
      default:
        // TODO
        // throw IllegalArgumentException();
        return null;
    }
  }

  /// where 0 -> Mon, 1 -> Tue, ...
  String getDayString(int day) {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day];
  }
}

// ignore: library_private_types_in_public_api
class OpeningHoursForDayState = _OpeningHoursForDayState with _$OpeningHoursForDayState;

/// EmptyList means closed
/// You can have as many (disjoint) OpeningIntervals per day as you please.
abstract class _OpeningHoursForDayState with Store {
  _OpeningHoursForDayState(this.openingIntervals);

  @observable
  ObservableList<OpeningIntervalState> openingIntervals;

  @observable
  String? timeFormatError;

  @action
  void addParsedIntervalIfValid(String startEnd) {
    try {
      final openingIntervalState = _OpeningIntervalState.parseOpeningIntervalState(startEnd) as OpeningIntervalState;
      timeFormatError = null;
      openingIntervals.add(openingIntervalState);
    } catch (e) {
      timeFormatError = 'Invalid time format';
    }
  }

  @action
  void addInterval(OpeningIntervalState interval) {
    openingIntervals.add(interval);
  }

  @action
  void removeInterval(int index) {
    openingIntervals.removeAt(index);
  }

  /// where 0 -> Mon, 1 -> Tue, ...
  /// (pitfall: overriding the toString method of this *abstract* class would
  /// not not be wise, as it will not be called, but instead the toString of the
  /// actually used class with a similar name will be called.)
  String humanReadable() {
    final asString = StringBuffer();
    if (openingIntervals.isEmpty) {
      asString.write('(closed)');
    } else {
      for (var i = 0; i < openingIntervals.length; i++) {
        asString
          ..write(openingIntervals[i].humanReadable())
          ..write(i < openingIntervals.length - 1 ? ', ' : '');
      }
    }
    return asString.toString();
  }
}

// ignore: library_private_types_in_public_api
class OpeningIntervalState = _OpeningIntervalState with _$OpeningIntervalState;

/// start and end in minutes since midnight of that day
abstract class _OpeningIntervalState with Store {
  _OpeningIntervalState(this.start, this.end);

  @observable
  int start;
  @observable
  int end;

  /// example "8:00-12:00" or "8:00 - 12:00"
  static _OpeningIntervalState parseOpeningIntervalState(String startEndTime) {
    return OpeningIntervalState(_parseTimeInterval(startEndTime, 0), _parseTimeInterval(startEndTime, 1));
  }

  static int _parseTimeInterval(String startEndTime, int part) {
    final startEnd = startEndTime.split('-');
    final parsed = <int>[];
    for (final value in startEnd) {
      parsed.add(_parseTime(value.trim()));
    }
    return (parsed[0] < parsed[1]) ? parsed[part % 2] : parsed[(part + 1) % 2];
  }

  static int _parseTime(String time) {
    final timeLowerCase = time.toLowerCase();
    final pm = timeLowerCase.contains('p') ? 12 * 60 : 0;
    final indexOfMeridiem = timeLowerCase.indexOf(RegExp('a|p'));
    final timeClean = indexOfMeridiem > 0 ? timeLowerCase.substring(0, indexOfMeridiem) : timeLowerCase;
    final hoursMinutes = timeClean.split(':');
    var hours = int.parse(hoursMinutes[0].trim());

    // 12am is midnight, 12pm is noon.
    hours = hours == 12 && timeLowerCase.contains('m') ? 0 : hours;
    final minutes = hoursMinutes.length > 1 ? int.parse(hoursMinutes[1].trim()) : 0;
    return (hours * 60 + minutes + pm) % (24 * 60);
  }

  String humanReadable() {
    return '${start ~/ 60}:${(start % 60 + 100).toString().substring(1)} - ${end ~/ 60}:${(end % 60 + 100).toString().substring(1)}';
  }
}
