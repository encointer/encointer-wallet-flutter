// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityReputationV1 _$CommunityReputationV1FromJson(Map<String, dynamic> json) => CommunityReputationV1(
      CommunityIdentifier.fromJson(json['communityIdentifier'] as Map<String, dynamic>),
      $enumDecode(_$ReputationEnumMap, json['reputation']),
    );

Map<String, dynamic> _$CommunityReputationV1ToJson(CommunityReputationV1 instance) => <String, dynamic>{
      'communityIdentifier': instance.communityIdentifier.toJson(),
      'reputation': _$ReputationEnumMap[instance.reputation]!,
    };

const _$ReputationEnumMap = {
  Reputation.Unverified: 'Unverified',
  Reputation.UnverifiedReputable: 'UnverifiedReputable',
  Reputation.VerifiedUnlinked: 'VerifiedUnlinked',
  Reputation.VerifiedLinked: 'VerifiedLinked',
};
