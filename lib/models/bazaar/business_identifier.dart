import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../communities/community_identifier.dart';
part 'business_identifier.g.dart';

/// Key to index businesses onchain. It is passed as argument to the rpc `bazaar_getOfferingsForBusiness`.
@JsonSerializable()
class BusinessIdentifier {
  BusinessIdentifier(this.cid, this.controller);

  /// community identifier of the community the business belongs to
  final CommunityIdentifier? cid;

  /// controller account of the business
  final String? controller;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory BusinessIdentifier.fromJson(Map<String, dynamic> json) => _$BusinessIdentifierFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessIdentifierToJson(this);
}
