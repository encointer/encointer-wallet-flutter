// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Businesses _$BusinessesFromJson(Map<String, dynamic> json) => Businesses(
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      address: json['address'] as String,
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
      openingHours: json['openingHours'] as String,
      logo: const ImageHashToLinkOrNullConverter().fromJson(json['logo'] as String?),
      photos: json['photos'] as String?,
      photo: json['photo'] as String?,
      telephone: json['telephone'] as String?,
      email: json['email'] as String?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      controller: json['controller'] as String?,
    );

Map<String, dynamic> _$BusinessesToJson(Businesses instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': _$CategoryEnumMap[instance.category]!,
      'photo': instance.photo,
      'address': instance.address,
      'telephone': instance.telephone,
      'email': instance.email,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'openingHours': instance.openingHours,
      'photos': instance.photos,
      'controller': instance.controller,
      'logo': const ImageHashToLinkOrNullConverter().toJson(instance.logo),
      'status': _$StatusEnumMap[instance.status],
    };

const _$CategoryEnumMap = {
  Category.all: 'all',
  Category.artAndMusic: 'art_music',
  Category.bodyAndSoul: 'body_soul',
  Category.fashionAndClothing: 'fashion_clothing',
  Category.foodAndBeverageStore: 'food_beverage_store',
  Category.restaurantsAndBars: 'restaurants_bars',
  Category.food: 'food',
};

const _$StatusEnumMap = {
  Status.highlight: 'highlight',
  Status.recently: 'new',
};
