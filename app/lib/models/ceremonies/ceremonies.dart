import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/utils/enum.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'ceremonies.g.dart';

@JsonSerializable(explicitToJson: true)
class AggregatedAccountData {
  AggregatedAccountData(this.global, this.personal);

  factory AggregatedAccountData.fromJson(Map<String, dynamic> json) => _$AggregatedAccountDataFromJson(json);
  Map<String, dynamic> toJson() => _$AggregatedAccountDataToJson(this);

  AggregatedAccountDataGlobal? global;
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

  ParticipantType? participantType;
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
class CommunityReputation {
  CommunityReputation(this.communityIdentifier, this.reputation);

  factory CommunityReputation.fromJson(Map<String, dynamic> json) => _$CommunityReputationFromJson(json);
  Map<String, dynamic> toJson() => _$CommunityReputationToJson(this);

  CommunityIdentifier? communityIdentifier;
  Reputation? reputation;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class Meetup {
  Meetup(this.index, this.locationIndex, this.time, this.registry);

  factory Meetup.fromJson(Map<String, dynamic> json) => _$MeetupFromJson(json);
  Map<String, dynamic> toJson() => _$MeetupToJson(this);

  int index;
  int locationIndex;
  // time is null in assigning phase
  int? time;
  List<String> registry;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// For compatibility with substrate's naming convention.
// ignore: constant_identifier_names
enum CeremonyPhase { Registering, Assigning, Attesting }

// For compatibility with substrate's naming convention.
// ignore: constant_identifier_names
enum Reputation { Unverified, UnverifiedReputable, VerifiedUnlinked, VerifiedLinked }

// -- Helper functions for above types

CeremonyPhase? ceremonyPhaseFromString(String value) {
  return getEnumFromString(CeremonyPhase.values, value);
}

Reputation? reputationFromString(String value) {
  return getEnumFromString(Reputation.values, value);
}

extension ReputationExtension on Reputation {
  String toValue() {
    return toEnumValue(this);
  }
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

/// Takes a `List<dynamic>` which contains a `List<List<[int, Map<String, dynamic>]>` and
/// transforms it into a `Map<int, CommunityReputation>`.
Map<int, CommunityReputation> reputationsFromList(List<dynamic> reputationsList) {
  final reputations = reputationsList.cast<List<dynamic>>();

  return {
    for (var cr in reputations) cr[0] as int: CommunityReputation.fromJson(cr[1] as Map<String, dynamic>),
  };
}
