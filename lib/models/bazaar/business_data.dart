import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'business_data.g.dart';

/// Business data living onchain
@JsonSerializable()
class BusinessData {
  BusinessData(this.url, this.lastOid);

  factory BusinessData.fromJson(Map<String, dynamic> json) => _$BusinessDataFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessDataToJson(this);

  /// ipfs-cid of the corresponding [IpfsBusiness]
  final String? url;

  /// monotonic counter of registered offerings
  final int? lastOid;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
