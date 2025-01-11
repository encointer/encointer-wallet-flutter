// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessData _$BusinessDataFromJson(Map<String, dynamic> json) => BusinessData(
      json['url'] as String?,
      (json['lastOid'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BusinessDataToJson(BusinessData instance) => <String, dynamic>{
      'url': instance.url,
      'lastOid': instance.lastOid,
    };
