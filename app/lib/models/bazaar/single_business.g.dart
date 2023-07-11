// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_business.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleBusiness _$SingleBusinessFromJson(Map<String, dynamic> json) => SingleBusiness(
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      address: json['address'] as String,
      zipcode: json['zipcode'] as String,
      addressDescription: json['addressDescription'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      openingHours1: json['openingHours1'] as String,
      openingHours2: json['openingHours2'] as String,
      logo: json['logo'] as String,
      photo: json['photo'] as String,
      offer: json['offer'] as String,
      offerName1: json['offerName1'] as String,
      offerName2: json['offerName2'] as String,
      moreInfo: json['moreInfo'] as String,
      status: json['status'] as String?,
      isLiked: json['isLiked'] as bool? ?? false,
      isLikedPersonally: json['isLikedPersonally'] as bool? ?? false,
      countLikes: json['countLikes'] as int? ?? 0,
    );

Map<String, dynamic> _$SingleBusinessToJson(SingleBusiness instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'address': instance.address,
      'zipcode': instance.zipcode,
      'addressDescription': instance.addressDescription,
      'telephone': instance.telephone,
      'email': instance.email,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'openingHours1': instance.openingHours1,
      'openingHours2': instance.openingHours2,
      'logo': instance.logo,
      'photo': instance.photo,
      'offer': instance.offer,
      'offerName1': instance.offerName1,
      'offerName2': instance.offerName2,
      'moreInfo': instance.moreInfo,
      'status': instance.status,
      'isLiked': instance.isLiked,
      'isLikedPersonally': instance.isLikedPersonally,
      'countLikes': instance.countLikes,
    };
