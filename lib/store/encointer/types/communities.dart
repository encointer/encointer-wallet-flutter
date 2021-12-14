import 'dart:convert';

import 'package:base58check/base58.dart';
import 'package:base58check/base58check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart

part 'communities.g.dart';

// explicit = true as we have nested Json with location
// field rename such that the fields match the ones defined in the runtime
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CommunityMetadata {
  CommunityMetadata(this.name, this.symbol, this.icons, this.url, this.theme);

  String name;
  String symbol;
  String icons;
  String url;
  CustomTheme theme;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CommunityMetadata.fromJson(Map<String, dynamic> json) => _$CommunityMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityMetadataToJson(this);
}

class CustomTheme {
  CustomTheme(this.primarySwatch);

  Color primarySwatch;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CustomTheme.fromJson(Map<String, dynamic> json) {
    return CustomTheme(Color(json['primary_swatch']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'primary_swatch': primarySwatch.value,
      };
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CommunityIdentifier {
  CommunityIdentifier(this.geohash, this.digest);

  // [u8; 5]
  final List<int> geohash;
  // [u8; 4]
  final List<int> digest;

  @override
  String toString() {
    return jsonEncode(this);
  }

  static CommunityIdentifier fromFmtString(String cid) {
    Base58Codec codec = Base58Codec(Base58CheckCodec.BITCOIN_ALPHABET);

    return CommunityIdentifier(utf8.encode(cid.substring(0, 5)), codec.decode(cid.substring(5)));
  }

  String toFmtString() {
    Base58Codec codec = Base58Codec(Base58CheckCodec.BITCOIN_ALPHABET);

    return utf8.decode(geohash) + codec.encode(digest);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommunityIdentifier &&
          runtimeType == other.runtimeType &&
          listEquals(geohash, other.geohash) &&
          listEquals(digest, other.digest);

  @override
  int get hashCode => geohash.hashCode ^ digest.hashCode;

  factory CommunityIdentifier.fromJson(Map<String, dynamic> json) => _$CommunityIdentifierFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityIdentifierToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CidName {
  CidName(this.cid, this.name);

  CommunityIdentifier cid;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory CidName.fromJson(Map<String, dynamic> json) => _$CidNameFromJson(json);

  Map<String, dynamic> toJson() => _$CidNameToJson(this);
}
