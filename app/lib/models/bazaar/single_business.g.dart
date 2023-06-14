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
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      openingHours: json['openingHours'] as String,
      logo: json['logo'] as String,
      photo: json['photo'] as String,
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
      'telephone': instance.telephone,
      'email': instance.email,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'openingHours': instance.openingHours,
      'logo': instance.logo,
      'photo': instance.photo,
      'status': instance.status,
      'isLiked': instance.isLiked,
      'isLikedPersonally': instance.isLikedPersonally,
      'countLikes': instance.countLikes,
    };
