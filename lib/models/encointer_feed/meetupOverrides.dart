import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'meetupOverrides.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.kebab)
class MeetupOverrides {
  MeetupOverrides(
    this.overrideName,
    this.network,
    this.communities,
    this.meetupTimes,
  );

  String overrideName;
  String network;
  List<String> communities;
  List<DateTime> meetupTimes;

  @override
  String toString() {
    return jsonEncode(this);
  }

  DateTime getNextMeetupTime(DateTime time) {
    return meetupTimes.firstWhere((mt) => time.isBefore(mt), orElse: () => null);
  }

  factory MeetupOverrides.fromJson(Map<String, dynamic> json) => _$MeetupOverridesFromJson(json);
  Map<String, dynamic> toJson() => _$MeetupOverridesToJson(this);
}
