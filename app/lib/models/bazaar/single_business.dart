import 'package:json_annotation/json_annotation.dart';

part 'single_business.g.dart';

@JsonSerializable()
class SingleBusiness {
  const SingleBusiness({
    required this.name,
    required this.description,
    required this.category,
    required this.address,
    required this.telephone,
    required this.email,
    required this.longitude,
    required this.latitude,
    required this.openingHours,
    required this.logo,
    required this.photo,
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
  final String telephone;
  final String email;
  final double longitude;
  final double latitude;
  final String openingHours;
  final String logo;
  final String photo;
  final String? status;
  final bool isLiked;
  final bool isLikedPersonally;
  final int countLikes;
}

const singleBusinessMockData = {
  'single_business': [
    // {
    //   'name': 'Kueche Edison',
    //   'description': 'bei uns gibt es köstlichen Kaffe',
    //   'category': 'food',
    //   'address': 'Technoparkstrasse 1, 8005 Zürich',
    //   'telephone': '+41 123 456 789',
    //   'email': 'info@kuecheedison.com',
    //   'longitude': 8.515962660312653,
    //   'latitude': 47.390349148891545,
    //   'openingHours': 'Mon-Fri 8h-18h',
    //   'logo': 'QmUH7W2eAWTfHRYYV1YitZaz54sTjEwv6udjZjh7Tg47Xv',
    //   'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/sorenbrod.png?raw=true'
    // },
    {
      'name': 'Hatha Lisa',
      'description':
          'Nutze deine Leu, um deinem Körper und Geist etwas Gutes zu tun. Besuche eine Yogastunde im Kreis 4 oder Kreis 5 mit Lisa Stähli, einer Hatha-Yoga-Lehrerin mit über 4 Jahren Unterrichtserfahrung. Die Klassen sind für alle Niveaus geeignet, werden auf Englisch unterrichtet und bieten sowohl eine Herausforderung als auch die Möglichkeit, sein Gleichgewicht zu finden.\n\nErfahre mehr oder kontaktiere uns:\nhttps://hathalisa.com/',
      'category': 'Body & Soul',
      'address': 'Zwinglistrasse, 8 8004',
      'telephone': '+41 123 456 789',
      'email': 'info@hathalisa.com',
      'longitude': 8.515962660312653,
      'latitude': 47.390349148891545,
      'openingHours': 'Mon-Fri 8h-18h',
      'logo': 'QmUH7W2eAWTfHRYYV1YitZaz54sTjEwv6udjZjh7Tg47Xv',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa.png?raw=true',
      'status': 'Neu bei Leu',
      'isLiked': false,
      'isLikedPersonally': false,
      'countLikes': 0
    },
  ]
};
