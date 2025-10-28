// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipfs_business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpfsBusiness _$IpfsBusinessFromJson(Map<String, dynamic> json) => IpfsBusiness(
      name: json['name'] as String,
      description: json['description'] as String,
      categoryRaw: json['category'] as String,
      address: json['address'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      openingHours: json['openingHours'] as String,
      addressDescription: json['addressDescription'] as String?,
      zipcode: json['zipcode'] as String?,
      logo: json['logo'] as String?,
      photos: json['photos'] as String?,
      photo: json['photo'] as String?,
      telephone: json['telephone'] as String?,
      email: json['email'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      moreInfo: json['moreInfo'] as String?,
      controller: json['controller'] as String?,
    );

Map<String, dynamic> _$IpfsBusinessToJson(IpfsBusiness instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'photo': instance.photo,
      'address': instance.address,
      'zipcode': instance.zipcode,
      'addressDescription': instance.addressDescription,
      'telephone': instance.telephone,
      'email': instance.email,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'openingHours': instance.openingHours,
      'moreInfo': instance.moreInfo,
      'photos': instance.photos,
      'controller': instance.controller,
      'logo': instance.logo,
      'status': _$StatusEnumMap[instance.status],
      'category': instance.categoryRaw,
    };

const _$StatusEnumMap = {
  Status.highlight: 'highlight',
  Status.recently: 'new',
};
