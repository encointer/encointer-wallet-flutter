// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipfs_offering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpfsOffering _$IpfsOfferingFromJson(Map<String, dynamic> json) => IpfsOffering(
      json['name'] as String?,
      (json['price'] as num?)?.toInt(),
      json['description'] as String?,
      json['contactInfo'] as String?,
      json['imagesCid'] as String?,
    );

Map<String, dynamic> _$IpfsOfferingToJson(IpfsOffering instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'contactInfo': instance.contactInfo,
      'imagesCid': instance.imagesCid,
    };
