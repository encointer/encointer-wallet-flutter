import 'package:json_annotation/json_annotation.dart';

part 'single_business.g.dart';

@JsonSerializable()
class SingleBusiness {
  SingleBusiness({
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
    required this.openingHours,
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

  String name;
  String description;
  String category;
  String address;
  String zipcode;
  String addressDescription;
  String telephone;
  String email;
  double longitude;
  double latitude;
  String openingHours;
  String logo;
  String photo;
  String offer;
  String offerName1;
  String offerName2;
  String moreInfo;
  String? status;
  bool isLiked;
  bool isLikedPersonally;
  int countLikes;
}
