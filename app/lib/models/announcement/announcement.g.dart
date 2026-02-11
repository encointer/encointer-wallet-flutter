// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      communityIdentifier: json['communityIdentifier'] as String,
      title: json['title'] as String,
      publisherSVG: json['publisherSVG'] as String,
      content: json['content'] as String,
      publishDate: DateTime.parse(json['publishDate'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
      countFavorite: (json['countFavorite'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) => <String, dynamic>{
      'communityIdentifier': instance.communityIdentifier,
      'title': instance.title,
      'publisherSVG': instance.publisherSVG,
      'content': instance.content,
      'publishDate': instance.publishDate.toIso8601String(),
      'isFavorite': instance.isFavorite,
      'countFavorite': instance.countFavorite,
    };
