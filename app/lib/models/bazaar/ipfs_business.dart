import 'package:encointer_wallet/models/bazaar/category.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ipfs_business.g.dart';

@JsonSerializable()
class IpfsBusiness {
  IpfsBusiness({
    required this.name,
    required this.description,
    required this.categoryRaw,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.openingHours,
    this.addressDescription,
    this.zipcode,
    this.logo,
    this.photos,
    this.photo,
    this.telephone,
    this.email,
    this.status,
    this.moreInfo,
    this.controller,
  });
  factory IpfsBusiness.fromJson(Map<String, dynamic> json) => _$IpfsBusinessFromJson(json);
  Map<String, dynamic> toJson() => _$IpfsBusinessToJson(this);

  final String name;
  final String description;
  final String? photo;
  final String address;
  final String? zipcode;
  final String? addressDescription;
  final String? telephone;
  final String? email;
  final String longitude;
  final String latitude;
  final String openingHours;
  final String? moreInfo;
  final String? photos;
  String? controller;
  final String? logo;
  final Status? status;

  @JsonKey(name: 'category')
  final String categoryRaw;

  /// Try to map [categoryRaw] to a known [Category] enum.
  Category get category => Category.fromJsonKey(categoryRaw);

  /// Human-readable name, including unknown backend values.
  String get categoryDisplayName {
    final cat = category;
    if (cat != Category.other) return cat.defaultLabel;

    // Unknown category: prettify backend value
    return _prettifySlug(categoryRaw);
  }

  /// Converts something like "local_art__and_crafts" → "Local Art & Crafts"
  String _prettifySlug(String slug) {
    final normalized = slug.replaceAll(RegExp('_+'), ' ').trim();
    if (normalized.isEmpty) return 'Other';
    return normalized
        .split(' ')
        .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }

  Color get statusColor {
    switch (status) {
      case Status.highlight:
        return const Color(0xFFE8FBFF);
      case Status.recently:
        return Colors.lightGreen.shade100;
      // ignore: no_default_cases
      default:
        return const Color(0xFFf4f7f8);
    }
  }
}

enum Status {
  @JsonValue('highlight')
  highlight('Highlight', Color(0xFF00A3FF)),
  @JsonValue('new')
  recently('New', Color(0xFF00BA77));

  const Status(
    this.name,
    this.textColor,
  );
  final String name;
  final Color textColor;

  TextStyle get textStyle {
    return TextStyle(color: textColor);
  }
}

const businessesMockData = {
  'businesses': [
    {
      'name': 'HIGHLIGHTED',
      'description': 'wir offerieren kühles Bier',
      'category': 'food',
      'photo': null,
      'address': 'Technoparkstrasse 1, 8005 Zürich',
      'telephone': null,
      'email': null,
      'longitude': '8.515377938747404',
      'latitude': '47.389401263868514',
      'openingHours': 'Mon-Fri 8h-18h',
      'photos': 'QmaQfq6Zr2yCMkSMe8VjSxoYd89hyzcJjeE8jTUG3uXpBG',
      'logo': 'QmcULG6AN5wwMfuwtpsMcjQmFwwUnSHsvSEUFLrCoWMpWh',
      'status': 'highlight',
    },
    {
      'name': 'NEW',
      'description': 'wir offerieren kühles Bier',
      'category': 'fashion_clothing',
      'photo': null,
      'address': 'Technoparkstrasse 1, 8005 Zürich',
      'telephone': null,
      'email': null,
      'longitude': '8.515377938747404',
      'latitude': '47.389401263868514',
      'openingHours': 'Mon-Fri 8h-18h',
      'photos': 'QmaQfq6Zr2yCMkSMe8VjSxoYd89hyzcJjeE8jTUG3uXpBG',
      'logo': 'QmcULG6AN5wwMfuwtpsMcjQmFwwUnSHsvSEUFLrCoWMpWh',
      'status': 'new',
    },
    {
      'name': 'NORMAL',
      'description': 'wir offerieren kühles Bier',
      'category': 'food_beverage_store',
      'photo': null,
      'address': 'Technoparkstrasse 1, 8005 Zürich',
      'telephone': null,
      'email': null,
      'longitude': '8.515377938747404',
      'latitude': '47.389401263868514',
      'openingHours': 'Mon-Fri 8h-18h',
      'photos': 'QmaQfq6Zr2yCMkSMe8VjSxoYd89hyzcJjeE8jTUG3uXpBG',
      'logo': 'QmcULG6AN5wwMfuwtpsMcjQmFwwUnSHsvSEUFLrCoWMpWh',
      'status': null,
    }
  ]
};
