import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart

part 'communityMetadata.g.dart';

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

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'primary_swatch': primarySwatch.value,
      };
}

