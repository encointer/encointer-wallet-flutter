// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Businesses _$BusinessesFromJson(Map<String, dynamic> json) => Businesses(
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$CategoryEnumMap, json['category']),
      photo: json['photo'] as String,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$BusinessesToJson(Businesses instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': _$CategoryEnumMap[instance.category]!,
      'photo': instance.photo,
      'status': _$StatusEnumMap[instance.status],
    };

const _$CategoryEnumMap = {
  Category.all: 'all',
  Category.artAndMusic: 'art_music',
  Category.bodyAndSoul: 'body_soul',
  Category.fashionAndClothing: 'fashion_clothing',
  Category.foodAndBeverageStore: 'food_beverage_store',
  Category.restaurantsAndBars: 'restaurants_bars',
};

const _$StatusEnumMap = {
  Status.highlight: 'highlight',
  Status.neuBeiLeu: 'neu_bei_leu',
};
