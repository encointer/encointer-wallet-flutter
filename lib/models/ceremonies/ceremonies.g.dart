// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:collection/collection.dart' show IterableExtension;
part of 'ceremonies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregatedAccountData _$AggregatedAccountDataFromJson(Map<String, dynamic> json) {
  return AggregatedAccountData(
    json['global'] == null ? null : AggregatedAccountDataGlobal.fromJson(json['global'] as Map<String, dynamic>),
    json['personal'] == null ? null : AggregatedAccountDataPersonal.fromJson(json['personal'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AggregatedAccountDataToJson(AggregatedAccountData instance) => <String, dynamic>{
      'global': instance.global?.toJson(),
      'personal': instance.personal?.toJson(),
    };

AggregatedAccountDataPersonal _$AggregatedAccountDataPersonalFromJson(Map<String, dynamic> json) {
  return AggregatedAccountDataPersonal(
    _$enumDecodeNullable(_$ParticipantTypeEnumMap, json['participantType']),
    json['meetupIndex'] as int?,
    json['meetupLocationIndex'] as int?,
    json['meetupTime'] as int?,
    (json['meetupRegistry'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$AggregatedAccountDataPersonalToJson(AggregatedAccountDataPersonal instance) => <String, dynamic>{
      'participantType': _$ParticipantTypeEnumMap[instance.participantType!],
      'meetupIndex': instance.meetupIndex,
      'meetupLocationIndex': instance.meetupLocationIndex,
      'meetupTime': instance.meetupTime,
      'meetupRegistry': instance.meetupRegistry,
    };

T? _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhereOrNull((e) => e.value == source)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T? _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ParticipantTypeEnumMap = {
  ParticipantType.Bootstrapper: 'Bootstrapper',
  ParticipantType.Reputable: 'Reputable',
  ParticipantType.Endorsee: 'Endorsee',
  ParticipantType.Newbie: 'Newbie',
};

AggregatedAccountDataGlobal _$AggregatedAccountDataGlobalFromJson(Map<String, dynamic> json) {
  return AggregatedAccountDataGlobal(
    _$enumDecodeNullable(_$CeremonyPhaseEnumMap, json['ceremonyPhase']),
    json['ceremonyIndex'] as int?,
  );
}

Map<String, dynamic> _$AggregatedAccountDataGlobalToJson(AggregatedAccountDataGlobal instance) => <String, dynamic>{
      'ceremonyPhase': _$CeremonyPhaseEnumMap[instance.ceremonyPhase!],
      'ceremonyIndex': instance.ceremonyIndex,
    };

const _$CeremonyPhaseEnumMap = {
  CeremonyPhase.Registering: 'Registering',
  CeremonyPhase.Assigning: 'Assigning',
  CeremonyPhase.Attesting: 'Attesting',
};

CommunityReputation _$CommunityReputationFromJson(Map<String, dynamic> json) {
  return CommunityReputation(
    json['communityIdentifier'] == null
        ? null
        : CommunityIdentifier.fromJson(json['communityIdentifier'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$ReputationEnumMap, json['reputation']),
  );
}

Map<String, dynamic> _$CommunityReputationToJson(CommunityReputation instance) => <String, dynamic>{
      'communityIdentifier': instance.communityIdentifier?.toJson(),
      'reputation': _$ReputationEnumMap[instance.reputation!],
    };

const _$ReputationEnumMap = {
  Reputation.Unverified: 'Unverified',
  Reputation.UnverifiedReputable: 'UnverifiedReputable',
  Reputation.VerifiedUnlinked: 'VerifiedUnlinked',
  Reputation.VerifiedLinked: 'VerifiedLinked',
};

Meetup _$MeetupFromJson(Map<String, dynamic> json) {
  return Meetup(
    json['index'] as int?,
    json['locationIndex'] as int?,
    json['time'] as int?,
    (json['registry'] as List?)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$MeetupToJson(Meetup instance) => <String, dynamic>{
      'index': instance.index,
      'locationIndex': instance.locationIndex,
      'time': instance.time,
      'registry': instance.registry,
    };
