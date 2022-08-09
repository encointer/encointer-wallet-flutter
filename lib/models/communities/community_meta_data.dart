import 'dart:convert';

import 'package:base58check/base58.dart';
import 'package:base58check/base58check.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/format.dart';

part 'community_meta_data.g.dart';

// explicit = true as we have nested Json with location
// field rename such that the fields match the ones defined in the runtime
@JsonSerializable(explicitToJson: true)
class CommunityMetadata {
  CommunityMetadata(this.name, this.symbol, this.assets, this.url, this.theme);

  String name;
  String symbol;
  String assets;
  String? url;
  String? theme;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) => _$CommunityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);
}
