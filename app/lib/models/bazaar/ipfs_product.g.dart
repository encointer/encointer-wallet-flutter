// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ipfs_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IpfsProduct _$IpfsProductFromJson(Map<String, dynamic> json) => IpfsProduct(
      json['name'] as String,
      json['description'] as String,
      json['category'] as String,
      const ImageHashToLinkOrNullConverter().fromJson(json['image'] as String?),
      json['itemCondition'] as String?,
      json['price'] as String?,
    );

Map<String, dynamic> _$IpfsProductToJson(IpfsProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'image': const ImageHashToLinkOrNullConverter().toJson(instance.image),
      'itemCondition': instance.itemCondition,
      'price': instance.price,
    };
