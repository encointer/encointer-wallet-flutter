// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMetadata _$CommunityMetadataFromJson(Map<String, dynamic> json) =>
    CommunityMetadata(
      json['name'] as String,
      json['symbol'] as String,
      json['assets'] as String,
      json['url'] as String?,
      json['theme'] as String?,
      (json['announcementSigner'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      $enumDecodeNullable(_$CommunityRulesEnumMap, json['rules']),
    );

Map<String, dynamic> _$CommunityMetadataToJson(CommunityMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'assets': instance.assets,
      'url': instance.url,
      'theme': instance.theme,
      'announcementSigner': instance.announcementSigner,
      'rules': _$CommunityRulesEnumMap[instance.rules],
    };

const _$CommunityRulesEnumMap = {
  CommunityRules.LoCo: 'LoCo',
  CommunityRules.LoCoFlex: 'LoCoFlex',
  CommunityRules.BeeDance: 'BeeDance',
};
