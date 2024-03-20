// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityReputation _$CommunityReputationFromJson(Map<String, dynamic> json) => CommunityReputation(
      CommunityIdentifier.fromJson(json['communityIdentifier'] as Map<String, dynamic>),
      Reputation.fromJson(json['reputation']),
    );

Map<String, dynamic> _$CommunityReputationToJson(CommunityReputation instance) => <String, dynamic>{
      'communityIdentifier': instance.communityIdentifier.toJson(),
      'reputation': instance.reputation.toJson(),
    };
