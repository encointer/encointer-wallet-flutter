import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  const Announcement({
    required this.communityIdentifier,
    required this.title,
    required this.publisherSVG,
    required this.content,
    required this.publishDate,
    this.isFavorite = false,
    this.countFavorite = 0,
  });
  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  final String communityIdentifier;
  final String title;
  final String publisherSVG;
  final String content;
  final DateTime publishDate;
  final bool isFavorite;
  final int countFavorite;
}
