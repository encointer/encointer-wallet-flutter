// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipfs_business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpfsBusiness _$IpfsBusinessFromJson(Map<String, dynamic> json) => IpfsBusiness(
      json['name'] as String?,
      json['description'] as String?,
      json['contactInfo'] as String?,
      json['imagesCid'] as String?,
      json['openingHours'] as String?,
    );

Map<String, dynamic> _$IpfsBusinessToJson(IpfsBusiness instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'contactInfo': instance.contactInfo,
      'imagesCid': instance.imagesCid,
      'openingHours': instance.openingHours,
    };
