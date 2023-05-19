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
    required this.photos,
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
  final List<String> photos;
}

const singleBusinessMockData = {
  'single_business': [
    {
      'name': 'Kueche Edison',
      'description': 'bei uns gibt es köstlichen Kaffe',
      'category': 'food',
      'address': 'Technoparkstrasse 1, 8005 Zürich',
      'telephone': '+41 123 456 789',
      'email': 'info@kuecheedison.com',
      'longitude': 8.515962660312653,
      'latitude': 47.390349148891545,
      'openingHours': 'Mon-Fri 8h-18h',
      'logo': 'QmUH7W2eAWTfHRYYV1YitZaz54sTjEwv6udjZjh7Tg47Xv',
      'photos': ''
    }
  ]
};
