// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityMetadata _$CommunityMetadataFromJson(Map<String, dynamic> json) {
  return CommunityMetadata(
    json['name'] as String,
    json['symbol'] as String,
    json['assets'] as String,
    json['url'] as String,
    json['theme'] as String,
  );
}

Map<String, dynamic> _$CommunityMetadataToJson(CommunityMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'assets': instance.assets,
      'url': instance.url,
      'theme': instance.theme,
    };

CidName _$CidNameFromJson(Map<String, dynamic> json) {
  return CidName(
    json['cid'] == null
        ? null
        : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
    json['name'] as String,
  );
}

Map<String, dynamic> _$CidNameToJson(CidName instance) => <String, dynamic>{
      'cid': instance.cid?.toJson(),
      'name': instance.name,
    };
