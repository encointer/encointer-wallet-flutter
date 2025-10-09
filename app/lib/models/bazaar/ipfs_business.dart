import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page-encointer/bazaar/businesses/widgets/dropdown_widget.dart';

part 'ipfs_business.g.dart';

@JsonSerializable()
class IpfsBusiness {
  IpfsBusiness({
    required this.name,
    required this.description,
    required this.category,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.openingHours,
    this.logo,
    this.photos,
    this.photo,
    this.telephone,
    this.email,
    this.status,
    this.controller,
  });
  factory IpfsBusiness.fromJson(Map<String, dynamic> json) => _$IpfsBusinessFromJson(json);
  Map<String, dynamic> toJson() => _$IpfsBusinessToJson(this);

  final String name;
  final String description;
  final Category category;
  final String? photo;
  final String address;
  final String? telephone;
  final String? email;
  final String longitude;
  final String latitude;
  final String openingHours;
  String? photos;
  String? controller;
  @ImageHashToLinkOrNullConverter()
  String? logo;
  final Status? status;
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

class ImageHashToLinkOrNullConverter implements JsonConverter<String?, String?> {
  const ImageHashToLinkOrNullConverter();

  @override
  String? fromJson(String? value) {
    return '$encointerIpfsUrl/$value';
  }

  @override
  String? toJson(String? val) => val;
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
