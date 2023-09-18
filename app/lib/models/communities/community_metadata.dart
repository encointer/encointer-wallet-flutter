import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.g.dart';

// explicit = true as we have nested Json with location
// field rename such that the fields match the ones defined in the runtime
@JsonSerializable(explicitToJson: true)
class CommunityMetadata {
  CommunityMetadata(this.name, this.symbol, this.assets, this.url, this.theme, this.announcementSigner, this.rules);

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) => _$CommunityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);

  String name;
  String symbol;
  String assets;
  String? url;
  String? theme;
  Map<String, String>? announcementSigner;

  /// Must be nullable to be backwards compatible with the cache for now.
  /// Can be removed in the future.
  CommunityRules? rules;

  @override
  String toString() {
    return jsonEncode(this);
  }

  CommunityRules get communityRules => rules ?? CommunityRules.LoCo;
}

// ignore: constant_identifier_names
enum CommunityRules { LoCo, LoCoLight, BeeDance }
