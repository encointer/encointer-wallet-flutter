// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opening_hours_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OpeningHoursState on _OpeningHoursState, Store {
  late final _$monAtom = Atom(name: '_OpeningHoursState.mon', context: context);

  @override
  OpeningHoursForDayState get mon {
    _$monAtom.reportRead();
    return super.mon;
  }

  @override
  set mon(OpeningHoursForDayState value) {
    _$monAtom.reportWrite(value, super.mon, () {
      super.mon = value;
    });
  }

  late final _$tueAtom = Atom(name: '_OpeningHoursState.tue', context: context);

  @override
  OpeningHoursForDayState get tue {
    _$tueAtom.reportRead();
    return super.tue;
  }

  @override
  set tue(OpeningHoursForDayState value) {
    _$tueAtom.reportWrite(value, super.tue, () {
      super.tue = value;
    });
  }

  late final _$wedAtom = Atom(name: '_OpeningHoursState.wed', context: context);

  @override
  OpeningHoursForDayState get wed {
    _$wedAtom.reportRead();
    return super.wed;
  }

  @override
  set wed(OpeningHoursForDayState value) {
    _$wedAtom.reportWrite(value, super.wed, () {
      super.wed = value;
    });
  }

  late final _$thuAtom = Atom(name: '_OpeningHoursState.thu', context: context);

  @override
  OpeningHoursForDayState get thu {
    _$thuAtom.reportRead();
    return super.thu;
  }

  @override
  set thu(OpeningHoursForDayState value) {
    _$thuAtom.reportWrite(value, super.thu, () {
      super.thu = value;
    });
  }

  late final _$friAtom = Atom(name: '_OpeningHoursState.fri', context: context);

  @override
  OpeningHoursForDayState get fri {
    _$friAtom.reportRead();
    return super.fri;
  }

  @override
  set fri(OpeningHoursForDayState value) {
    _$friAtom.reportWrite(value, super.fri, () {
      super.fri = value;
    });
  }

  late final _$satAtom = Atom(name: '_OpeningHoursState.sat', context: context);

  @override
  OpeningHoursForDayState get sat {
    _$satAtom.reportRead();
    return super.sat;
  }

  @override
  set sat(OpeningHoursForDayState value) {
    _$satAtom.reportWrite(value, super.sat, () {
      super.sat = value;
    });
  }

  late final _$sunAtom = Atom(name: '_OpeningHoursState.sun', context: context);

  @override
  OpeningHoursForDayState get sun {
    _$sunAtom.reportRead();
    return super.sun;
  }

  @override
  set sun(OpeningHoursForDayState value) {
    _$sunAtom.reportWrite(value, super.sun, () {
      super.sun = value;
    });
  }

  late final _$copiedOpeningHoursAtom = Atom(name: '_OpeningHoursState.copiedOpeningHours', context: context);

  @override
  OpeningHoursForDayState? get copiedOpeningHours {
    _$copiedOpeningHoursAtom.reportRead();
    return super.copiedOpeningHours;
  }

  @override
  set copiedOpeningHours(OpeningHoursForDayState? value) {
    _$copiedOpeningHoursAtom.reportWrite(value, super.copiedOpeningHours, () {
      super.copiedOpeningHours = value;
    });
  }

  late final _$dayOnFocusAtom = Atom(name: '_OpeningHoursState.dayOnFocus', context: context);

  @override
  int? get dayOnFocus {
    _$dayOnFocusAtom.reportRead();
    return super.dayOnFocus;
  }

  @override
  set dayOnFocus(int? value) {
    _$dayOnFocusAtom.reportWrite(value, super.dayOnFocus, () {
      super.dayOnFocus = value;
    });
  }

  late final _$dayToCopyFromAtom = Atom(name: '_OpeningHoursState.dayToCopyFrom', context: context);

  @override
  int? get dayToCopyFrom {
    _$dayToCopyFromAtom.reportRead();
    return super.dayToCopyFrom;
  }

  @override
  set dayToCopyFrom(int? value) {
    _$dayToCopyFromAtom.reportWrite(value, super.dayToCopyFrom, () {
      super.dayToCopyFrom = value;
    });
  }

  late final _$_OpeningHoursStateActionController = ActionController(name: '_OpeningHoursState', context: context);

  @override
  void copyFrom(int day) {
    final _$actionInfo = _$_OpeningHoursStateActionController.startAction(name: '_OpeningHoursState.copyFrom');
    try {
      return super.copyFrom(day);
    } finally {
      _$_OpeningHoursStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDayOnFocus(int day) {
    final _$actionInfo = _$_OpeningHoursStateActionController.startAction(name: '_OpeningHoursState.setDayOnFocus');
    try {
      return super.setDayOnFocus(day);
    } finally {
      _$_OpeningHoursStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pasteOpeningHoursTo(int day) {
    final _$actionInfo =
        _$_OpeningHoursStateActionController.startAction(name: '_OpeningHoursState.pasteOpeningHoursTo');
    try {
      return super.pasteOpeningHoursTo(day);
    } finally {
      _$_OpeningHoursStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mon: ${mon},
tue: ${tue},
wed: ${wed},
thu: ${thu},
fri: ${fri},
sat: ${sat},
sun: ${sun},
copiedOpeningHours: ${copiedOpeningHours},
dayOnFocus: ${dayOnFocus},
dayToCopyFrom: ${dayToCopyFrom}
    ''';
  }
}

mixin _$OpeningHoursForDayState on _OpeningHoursForDayState, Store {
  late final _$openingIntervalsAtom = Atom(name: '_OpeningHoursForDayState.openingIntervals', context: context);

  @override
  ObservableList<OpeningIntervalState> get openingIntervals {
    _$openingIntervalsAtom.reportRead();
    return super.openingIntervals;
  }

  @override
  set openingIntervals(ObservableList<OpeningIntervalState> value) {
    _$openingIntervalsAtom.reportWrite(value, super.openingIntervals, () {
      super.openingIntervals = value;
    });
  }

  late final _$timeFormatErrorAtom = Atom(name: '_OpeningHoursForDayState.timeFormatError', context: context);

  @override
  String? get timeFormatError {
    _$timeFormatErrorAtom.reportRead();
    return super.timeFormatError;
  }

  @override
  set timeFormatError(String? value) {
    _$timeFormatErrorAtom.reportWrite(value, super.timeFormatError, () {
      super.timeFormatError = value;
    });
  }

  late final _$_OpeningHoursForDayStateActionController =
      ActionController(name: '_OpeningHoursForDayState', context: context);

  @override
  void addParsedIntervalIfValid(String startEnd) {
    final _$actionInfo = _$_OpeningHoursForDayStateActionController.startAction(
        name: '_OpeningHoursForDayState.addParsedIntervalIfValid');
    try {
      return super.addParsedIntervalIfValid(startEnd);
    } finally {
      _$_OpeningHoursForDayStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addInterval(OpeningIntervalState interval) {
    final _$actionInfo =
        _$_OpeningHoursForDayStateActionController.startAction(name: '_OpeningHoursForDayState.addInterval');
    try {
      return super.addInterval(interval);
    } finally {
      _$_OpeningHoursForDayStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeInterval(int index) {
    final _$actionInfo =
        _$_OpeningHoursForDayStateActionController.startAction(name: '_OpeningHoursForDayState.removeInterval');
    try {
      return super.removeInterval(index);
    } finally {
      _$_OpeningHoursForDayStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
openingIntervals: ${openingIntervals},
timeFormatError: ${timeFormatError}
    ''';
  }
}

mixin _$OpeningIntervalState on _OpeningIntervalState, Store {
  late final _$startAtom = Atom(name: '_OpeningIntervalState.start', context: context);

  @override
  int get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(int value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  late final _$endAtom = Atom(name: '_OpeningIntervalState.end', context: context);

  @override
  int get end {
    _$endAtom.reportRead();
    return super.end;
  }

  @override
  set end(int value) {
    _$endAtom.reportWrite(value, super.end, () {
      super.end = value;
    });
  }

  @override
  String toString() {
    return '''
start: ${start},
end: ${end}
    ''';
  }
}
