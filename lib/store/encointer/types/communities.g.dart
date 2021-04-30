// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMetadata _$CommunityMetadataFromJson(Map<String, dynamic> json) {
  return CommunityMetadata(
    json['name'] as String,
    json['symbol'] as String,
    json['icons'] as String,
    json['url'] as String,
    json['theme'] == null
        ? null
        : CustomTheme.fromJson(json['theme'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommunityMetadataToJson(CommunityMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'icons': instance.icons,
      'url': instance.url,
      'theme': instance.theme?.toJson(),
    };
