import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;
import 'package:encointer_wallet/utils/enum.dart';

export 'reputation/v1.dart';
export 'reputation/v2.dart';

part 'ceremonies.g.dart';

@JsonSerializable(explicitToJson: true)
class AggregatedAccountData {
  AggregatedAccountData(this.global, this.personal);

  factory AggregatedAccountData.fromJson(Map<String, dynamic> json) => _$AggregatedAccountDataFromJson(json);

  Map<String, dynamic> toJson() => _$AggregatedAccountDataToJson(this);

  AggregatedAccountDataGlobal global;
  AggregatedAccountDataPersonal? personal;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AggregatedAccountDataPersonal {
  AggregatedAccountDataPersonal(
      this.participantType, this.meetupIndex, this.meetupLocationIndex, this.meetupTime, this.meetupRegistry);

  factory AggregatedAccountDataPersonal.fromJson(Map<String, dynamic> json) =>
      _$AggregatedAccountDataPersonalFromJson(json);

  Map<String, dynamic> toJson() => _$AggregatedAccountDataPersonalToJson(this);

  ParticipantType participantType;
  int? meetupIndex;
  int? meetupLocationIndex;
  int? meetupTime;
  List<String>? meetupRegistry;

  Meetup? get meetup =>
      meetupIndex != null ? Meetup(meetupIndex!, meetupLocationIndex!, meetupTime, meetupRegistry!) : null;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AggregatedAccountDataGlobal {
  AggregatedAccountDataGlobal(this.ceremonyPhase, this.ceremonyIndex);

  factory AggregatedAccountDataGlobal.fromJson(Map<String, dynamic> json) =>
      _$AggregatedAccountDataGlobalFromJson(json);

  Map<String, dynamic> toJson() => _$AggregatedAccountDataGlobalToJson(this);

  CeremonyPhase ceremonyPhase;
  int ceremonyIndex;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// For compatibility with substrate's naming convention.
// ignore: constant_identifier_names
enum ParticipantType { Bootstrapper, Reputable, Endorsee, Newbie }

@JsonSerializable()
class Meetup {
  Meetup(this.index, this.locationIndex, this.time, this.registry);

  factory Meetup.fromJson(Map<String, dynamic> json) => _$MeetupFromJson(json);

  Map<String, dynamic> toJson() => _$MeetupToJson(this);

  int index;
  int locationIndex;

  // time is null in assigning phase
  int? time;

  /// Addresses belonging to the meetup encoded with prefix 42.
  List<String> registry;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// For compatibility with substrate's naming convention.
// ignore: constant_identifier_names
enum CeremonyPhase { Registering, Assigning, Attesting }

// -- Helper functions for above types

CeremonyPhase ceremonyPhaseTypeFromPolkadart(et.CeremonyPhaseType phase) {
  switch (phase) {
    case et.CeremonyPhaseType.registering:
      return CeremonyPhase.Registering;
    case et.CeremonyPhaseType.assigning:
      return CeremonyPhase.Assigning;
    case et.CeremonyPhaseType.attesting:
      return CeremonyPhase.Attesting;
  }
}

CeremonyPhase? ceremonyPhaseFromString(String value) {
  return getEnumFromString(CeremonyPhase.values, value);
}

extension ParticipantTypeExtension on ParticipantType {
  String toValue() {
    return toEnumValue(this);
  }

  bool get isReputable => this == ParticipantType.Reputable;
}

extension CeremonyPhaseExtension on CeremonyPhase {
  String toValue() {
    return toEnumValue(this);
  }
}
