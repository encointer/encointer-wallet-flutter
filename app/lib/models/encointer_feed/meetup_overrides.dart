import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:encointer_wallet/models/ceremonies/ceremonies.dart';
import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'meetup_overrides.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class MeetupOverrides {
  MeetupOverrides(
    this.overrideName,
    this.network,
    this.communities,
    this.meetupTimes,
  );

  factory MeetupOverrides.fromJson(Map<String, dynamic> json) => _$MeetupOverridesFromJson(json);
  Map<String, dynamic> toJson() => _$MeetupOverridesToJson(this);

  String? overrideName;
  String? network;
  List<String>? communities;
  List<DateTime>? meetupTimes;

  @override
  String toString() {
    return jsonEncode(this);
  }

  /// Returns the next meetup time.
  ///
  /// If it is in the `Attesting` phase it returns the meetup time of the currently ongoing meetup.
  DateTime? getNextMeetupTime(DateTime time, CeremonyPhase? phase) {
    meetupTimes!.sort();

    if (phase != CeremonyPhase.Attesting) {
      return meetupTimes!.firstWhereOrNull((mt) => time.isBefore(mt));
    } else {
      return meetupTimes!.reversed.firstWhereOrNull((mt) => time.isAfter(mt));
    }
  }
}
