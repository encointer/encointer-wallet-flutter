// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ceremonies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregatedAccountData _$AggregatedAccountDataFromJson(Map<String, dynamic> json) => AggregatedAccountData(
      AggregatedAccountDataGlobal.fromJson(json['global'] as Map<String, dynamic>),
      json['personal'] == null
          ? null
          : AggregatedAccountDataPersonal.fromJson(json['personal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AggregatedAccountDataToJson(AggregatedAccountData instance) => <String, dynamic>{
      'global': instance.global.toJson(),
      'personal': instance.personal?.toJson(),
    };

AggregatedAccountDataPersonal _$AggregatedAccountDataPersonalFromJson(Map<String, dynamic> json) =>
    AggregatedAccountDataPersonal(
      $enumDecode(_$ParticipantTypeEnumMap, json['participantType']),
      (json['meetupIndex'] as num?)?.toInt(),
      (json['meetupLocationIndex'] as num?)?.toInt(),
      (json['meetupTime'] as num?)?.toInt(),
      (json['meetupRegistry'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AggregatedAccountDataPersonalToJson(AggregatedAccountDataPersonal instance) => <String, dynamic>{
      'participantType': _$ParticipantTypeEnumMap[instance.participantType]!,
      'meetupIndex': instance.meetupIndex,
      'meetupLocationIndex': instance.meetupLocationIndex,
      'meetupTime': instance.meetupTime,
      'meetupRegistry': instance.meetupRegistry,
    };

const _$ParticipantTypeEnumMap = {
  ParticipantType.Bootstrapper: 'Bootstrapper',
  ParticipantType.Reputable: 'Reputable',
  ParticipantType.Endorsee: 'Endorsee',
  ParticipantType.Newbie: 'Newbie',
};

AggregatedAccountDataGlobal _$AggregatedAccountDataGlobalFromJson(Map<String, dynamic> json) =>
    AggregatedAccountDataGlobal(
      $enumDecode(_$CeremonyPhaseEnumMap, json['ceremonyPhase']),
      (json['ceremonyIndex'] as num).toInt(),
    );

Map<String, dynamic> _$AggregatedAccountDataGlobalToJson(AggregatedAccountDataGlobal instance) => <String, dynamic>{
      'ceremonyPhase': _$CeremonyPhaseEnumMap[instance.ceremonyPhase]!,
      'ceremonyIndex': instance.ceremonyIndex,
    };

const _$CeremonyPhaseEnumMap = {
  CeremonyPhase.Registering: 'Registering',
  CeremonyPhase.Assigning: 'Assigning',
  CeremonyPhase.Attesting: 'Attesting',
};

Meetup _$MeetupFromJson(Map<String, dynamic> json) => Meetup(
      (json['index'] as num).toInt(),
      (json['locationIndex'] as num).toInt(),
      (json['time'] as num?)?.toInt(),
      (json['registry'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MeetupToJson(Meetup instance) => <String, dynamic>{
      'index': instance.index,
      'locationIndex': instance.locationIndex,
      'time': instance.time,
      'registry': instance.registry,
    };
