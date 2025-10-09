import 'dart:convert';

import 'package:encointer_wallet/models/bazaar/ipfs_business.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ipfs_product.g.dart';

/// Product metadata living in ipfs
@JsonSerializable()
class IpfsProduct {
  IpfsProduct(
    this.name,
    this.description,
    this.category,
    this.image,
    this.itemCondition,
    this.price,
  );

  factory IpfsProduct.fromJson(Map<String, dynamic> json) => _$IpfsProductFromJson(json);
  Map<String, dynamic> toJson() => _$IpfsProductToJson(this);

  /// name of the business
  final String name;

  /// brief description of the business
  final String description;

  /// contact info of the business
  final String category;

  /// ipfs-cid where the images live
  @ImageHashToLinkOrNullConverter()
  final String? image;

  final String? itemCondition;

  /// comes from [ItemOffered]
  String? price;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
