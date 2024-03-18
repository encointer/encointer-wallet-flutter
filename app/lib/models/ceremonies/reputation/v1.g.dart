// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityReputation _$CommunityReputationFromJson(Map<String, dynamic> json) => CommunityReputation(
      CommunityIdentifier.fromJson(json['communityIdentifier'] as Map<String, dynamic>),
      $enumDecode(_$ReputationEnumMap, json['reputation']),
    );

Map<String, dynamic> _$CommunityReputationToJson(CommunityReputation instance) => <String, dynamic>{
      'communityIdentifier': instance.communityIdentifier.toJson(),
      'reputation': _$ReputationEnumMap[instance.reputation]!,
    };

const _$ReputationEnumMap = {
  Reputation.Unverified: 'Unverified',
  Reputation.UnverifiedReputable: 'UnverifiedReputable',
  Reputation.VerifiedUnlinked: 'VerifiedUnlinked',
  Reputation.VerifiedLinked: 'VerifiedLinked',
};
