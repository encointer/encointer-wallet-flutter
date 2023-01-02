import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'ipfs_offering.g.dart';

/// Offering metadata living in ipfs
@JsonSerializable()
class IpfsOffering {
  IpfsOffering(this.name, this.price, this.description, this.contactInfo, this.imagesCid);

  factory IpfsOffering.fromJson(Map<String, dynamic> json) => _$IpfsOfferingFromJson(json);
  Map<String, dynamic> toJson() => _$IpfsOfferingToJson(this);

  /// name of the offering
  final String? name;

  /// price in community currency
  final int? price;

  /// description of the offering
  final String? description;

  /// contact info of the business
  final String? contactInfo;

  /// ipfs-cid where the offering's images live
  final String? imagesCid;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
