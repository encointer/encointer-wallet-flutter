import 'dart:convert';

import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/enum.dart';
import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'ceremonies.g.dart';

@JsonSerializable(explicitToJson: true)
class AggregatedAccountData {
  AggregatedAccountData(this.global, this.personal);

  AggregatedAccountDataGlobal? global;
  AggregatedAccountDataPersonal? personal;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory AggregatedAccountData.fromJson(Map<String, dynamic> json) => _$AggregatedAccountDataFromJson(json);
  Map<String, dynamic> toJson() => _$AggregatedAccountDataToJson(this);
}

@JsonSerializable()
class AggregatedAccountDataPersonal {
  AggregatedAccountDataPersonal(
      this.participantType, this.meetupIndex, this.meetupLocationIndex, this.meetupTime, this.meetupRegistry);

  ParticipantType? participantType;
  int? meetupIndex;
  int? meetupLocationIndex;
  int? meetupTime;
  List<String>? meetupRegistry;

  get meetup => meetupIndex != null ? Meetup(meetupIndex, meetupLocationIndex, meetupTime, meetupRegistry) : null;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory AggregatedAccountDataPersonal.fromJson(Map<String, dynamic> json) =>
      _$AggregatedAccountDataPersonalFromJson(json);
  Map<String, dynamic> toJson() => _$AggregatedAccountDataPersonalToJson(this);
}

@JsonSerializable()
class AggregatedAccountDataGlobal {
  AggregatedAccountDataGlobal(this.ceremonyPhase, this.ceremonyIndex);

  CeremonyPhase? ceremonyPhase;
  int? ceremonyIndex;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory AggregatedAccountDataGlobal.fromJson(Map<String, dynamic> json) =>
      _$AggregatedAccountDataGlobalFromJson(json);
  Map<String, dynamic> toJson() => _$AggregatedAccountDataGlobalToJson(this);
}

enum ParticipantType { Bootstrapper, Reputable, Endorsee, Newbie }

@JsonSerializable()
class CommunityReputation {
  CommunityReputation(this.communityIdentifier, this.reputation);

  CommunityIdentifier? communityIdentifier;
  Reputation? reputation;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityReputation.fromJson(Map<String, dynamic> json) => _$CommunityReputationFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityReputationToJson(this);
}

@JsonSerializable()
class Meetup {
  Meetup(this.index, this.locationIndex, this.time, this.registry);

  int index;
  int locationIndex;
  int time;
  List<String> registry;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory Meetup.fromJson(Map<String, dynamic> json) => _$MeetupFromJson(json);
  Map<String, dynamic> toJson() => _$MeetupToJson(this);
}

enum CeremonyPhase { Registering, Assigning, Attesting }

enum Reputation { Unverified, UnverifiedReputable, VerifiedUnlinked, VerifiedLinked }

// -- Helper functions for above types

CeremonyPhase? ceremonyPhaseFromString(String? value) {
  return getEnumFromString(CeremonyPhase.values, value);
}

Reputation? reputationFromString(String value) {
  return getEnumFromString(Reputation.values, value);
}

extension reputationExtension on Reputation {
  String toValue() {
    return toEnumValue(this);
  }
}

extension participantTypeExtension on ParticipantType? {
  String toValue() {
    return toEnumValue(this);
  }
}

extension ceremonyPhaseExtension on CeremonyPhase {
  String toValue() {
    return toEnumValue(this);
  }
}
