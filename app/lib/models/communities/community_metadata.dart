import 'dart:convert';

import 'package:ew_polkadart/encointer_types.dart' as et;
import 'package:json_annotation/json_annotation.dart';

part 'community_metadata.g.dart';

// explicit = true as we have nested Json with location
// field rename such that the fields match the ones defined in the runtime
@JsonSerializable(explicitToJson: true)
class CommunityMetadata {
  CommunityMetadata(this.name, this.symbol, this.assets, this.url, this.theme, this.announcementSigner, this.rules);

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) => _$CommunityMetadataFromJson(json);

  factory CommunityMetadata.fromPolkadart(et.CommunityMetadata cm) {
    return CommunityMetadata(
      utf8.decode(cm.name),
      utf8.decode(cm.symbol),
      utf8.decode(cm.assets),
      cm.url != null ? utf8.decode(cm.url!) : null,
      cm.theme != null ? utf8.decode(cm.theme!) : null,
      // Todo: support announcement signer
      null,
      communityRulesFromPolkadart(cm.rules),
    );
  }

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);

  String name;
  String symbol;
  String assets;
  String? url;
  String? theme;
  Map<String, String>? announcementSigner;

  /// Must be nullable to be backwards compatible with the cache for now.
  /// Can be non-nullable in the future.
  CommunityRules? rules;

  @override
  String toString() {
    return jsonEncode(this);
  }

  CommunityRules get communityRules => rules ?? CommunityRules.LoCo;
}

// ignore: constant_identifier_names
enum CommunityRules { LoCo, LoCoFlex, BeeDance }

extension CommunityRulesExt on CommunityRules {
  bool get isLoCo => this == CommunityRules.LoCo;

  bool get isLoCoFlex => this == CommunityRules.LoCoFlex;

  bool get isBeeDance => this == CommunityRules.BeeDance;
}

CommunityRules communityRulesFromPolkadart(et.CommunityRules rules) {
  switch (rules) {
    case et.CommunityRules.loCo:
      return CommunityRules.LoCo;
    case et.CommunityRules.loCoFlex:
      return CommunityRules.LoCoFlex;
    case et.CommunityRules.beeDance:
      return CommunityRules.BeeDance;
  }
}
