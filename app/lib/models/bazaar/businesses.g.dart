// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'businesses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Businesses _$BusinessesFromJson(Map<String, dynamic> json) => Businesses(
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$BusinessesToJson(Businesses instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'photo': instance.photo,
    };
