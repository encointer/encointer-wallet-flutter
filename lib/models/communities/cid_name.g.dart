// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cid_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CidName _$CidNameFromJson(Map<String, dynamic> json) => CidName(
      CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
      json['name'] as String,
    );

Map<String, dynamic> _$CidNameToJson(CidName instance) => <String, dynamic>{
      'cid': instance.cid.toJson(),
      'name': instance.name,
    };
