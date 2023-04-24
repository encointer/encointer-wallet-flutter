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
  });
  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  final String communityIdentifier;
  final String title;
  final String publisherSVG;
  final String content;
  final DateTime publishDate;
}

const announcementMockData = {
  'announcement': [
    {
      'communityIdentifier': '1',
      'title': 'This is a title',
      'publisherSVG': 'assets/nctr_logo_faces_only_thick.svg',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
      'publishDate': '2023-04-24 09:44:11.377',
    },
    {
      'communityIdentifier': '2',
      'title': 'This is a title',
      'publisherSVG': 'assets/nctr_logo_faces_only_thick.svg',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
      'publishDate': '2023-04-24 09:44:11.377',
    },
    {
      'communityIdentifier': '3',
      'title': 'This is a title',
      'publisherSVG': 'assets/nctr_logo_faces_only_thick.svg',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ac elementum orci. Etiam fringilla augue non nisi accumsan euismod. Orci varius natoque penatibus et magnis dis parturient montes, nascetur rcommunityIdentifiericulus mus.',
      'publishDate': '2023-04-24 09:44:11.377',
    },
  ]
};
