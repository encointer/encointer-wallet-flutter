import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'ipfs_business.g.dart';

/// Business metadata living in ipfs
@JsonSerializable()
class IpfsBusiness {
  IpfsBusiness(this.name, this.description, this.contactInfo, this.imagesCid, this.openingHours);

  factory IpfsBusiness.fromJson(Map<String, dynamic> json) => _$IpfsBusinessFromJson(json);
  Map<String, dynamic> toJson() => _$IpfsBusinessToJson(this);

  /// name of the business
  final String? name;

  /// brief description of the business
  final String? description;

  /// contact info of the business
  final String? contactInfo;

  /// ipfs-cid where the images live
  final String? imagesCid;

  /// opening hours of the business
  /// Todo: change to an actual date format instead of string
  final String? openingHours;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
