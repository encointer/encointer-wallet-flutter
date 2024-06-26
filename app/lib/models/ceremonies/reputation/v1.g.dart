// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityReputationV1 _$CommunityReputationV1FromJson(Map<String, dynamic> json) => CommunityReputationV1(
      CommunityIdentifier.fromJson(json['communityIdentifier'] as Map<String, dynamic>),
      $enumDecode(_$ReputationV1EnumMap, json['reputation']),
    );

Map<String, dynamic> _$CommunityReputationV1ToJson(CommunityReputationV1 instance) => <String, dynamic>{
      'communityIdentifier': instance.communityIdentifier.toJson(),
      'reputation': _$ReputationV1EnumMap[instance.reputation]!,
    };

const _$ReputationV1EnumMap = {
  ReputationV1.Unverified: 'Unverified',
  ReputationV1.UnverifiedReputable: 'UnverifiedReputable',
  ReputationV1.VerifiedUnlinked: 'VerifiedUnlinked',
  ReputationV1.VerifiedLinked: 'VerifiedLinked',
};
