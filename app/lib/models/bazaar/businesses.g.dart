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
  Category.all: 'All',
  Category.artAndMusic: 'Art & Music',
  Category.bodyAndSoul: 'Body & Soul',
  Category.fashionAndClothing: 'Fashion & Clothing',
  Category.foodAndBeverageStore: 'Food & Beverage Store',
  Category.restaurantsAndBars: 'Restaurants & Bars',
};

const _$StatusEnumMap = {
  Status.highlight: 'Highlight',
  Status.neuBeiLeu: 'Neu bei Leu',
};
