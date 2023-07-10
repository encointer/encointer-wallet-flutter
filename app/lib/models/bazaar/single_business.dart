import 'package:json_annotation/json_annotation.dart';

part 'single_business.g.dart';

@JsonSerializable()
class SingleBusiness {
  const SingleBusiness({
    required this.name,
    required this.description,
    required this.category,
    required this.address,
    required this.zipcode,
    required this.addressDescription,
    required this.telephone,
    required this.email,
    required this.longitude,
    required this.latitude,
    required this.openingHours1,
    required this.openingHours2,
    required this.logo,
    required this.photo,
    required this.offer,
    required this.offerName1,
    required this.offerName2,
    required this.moreInfo,
    this.status,
    this.isLiked = false,
    this.isLikedPersonally = false,
    this.countLikes = 0,
  });
  factory SingleBusiness.fromJson(Map<String, dynamic> json) => _$SingleBusinessFromJson(json);
  Map<String, dynamic> toJson() => _$SingleBusinessToJson(this);

  final String name;
  final String description;
  final String category;
  final String address;
  final String zipcode;
  final String addressDescription;
  final String telephone;
  final String email;
  final double longitude;
  final double latitude;
  final String openingHours1;
  final String openingHours2;
  final String logo;
  final String photo;
  final String offer;
  final String offerName1;
  final String offerName2;
  final String moreInfo;
  final String? status;
  final bool isLiked;
  final bool isLikedPersonally;
  final int countLikes;
}

const singleBusinessMockData = {
  'name': 'Hatha Lisa',
  'description':
      'Nutze deine Leu, um deinem Körper und Geist etwas Gutes zu tun. Besuche eine Yogastunde im Kreis 4 oder Kreis 5 mit Lisa Stähli, einer Hatha-Yoga-Lehrerin mit über 4 Jahren Unterrichtserfahrung. Die Klassen sind für alle Niveaus geeignet, werden auf Englisch unterrichtet und bieten sowohl eine Herausforderung als auch die Möglichkeit, sein Gleichgewicht zu finden.\n\nErfahre mehr oder kontaktiere uns:\nhttps://hathalisa.com/',
  'category': 'Body & Soul',
  'addressDescription': 'Yoga Studio Zürich',
  'address': 'Zwinglistrasse, 8',
  'zipcode': '8004, Zürich',
  'telephone': '+41 123 456 789',
  'email': 'info@hathalisa.com',
  'longitude': 8.515962660312653,
  'latitude': 47.390349148891545,
  'openingHours1': 'Tuesdays 07:30-08:30',
  'openingHours2': 'Wednesday 12:15-13:20',
  'logo': 'QmUH7W2eAWTfHRYYV1YitZaz54sTjEwv6udjZjh7Tg47Xv',
  'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha_lisa_single_b.png?raw=true',
  'offer': 'Offer for Leu',
  'offerName1': 'Single course LEU 25',
  'offerName2': '10-course subscription LEU 200',
  'moreInfo': 'With Leu since 01 January 2023',
  'status': 'Neu bei Leu',
  'isLiked': false,
  'isLikedPersonally': false,
  'countLikes': 0
};
