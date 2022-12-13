import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'offering_data.g.dart';

/// Offering data living onchain
@JsonSerializable()
class OfferingData {
  OfferingData(this.url);

  factory OfferingData.fromJson(Map<String, dynamic> json) => _$OfferingDataFromJson(json);
  Map<String, dynamic> toJson() => _$OfferingDataToJson(this);

  /// ipfs-cid of the corresponding [IpfsOffering]
  final String? url;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
