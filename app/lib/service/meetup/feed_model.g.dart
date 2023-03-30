// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feed _$FeedFromJson(Map<String, dynamic> json) => Feed(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      showAt: DateTime.parse(json['showAt'] as String),
    );

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'showAt': instance.showAt.toIso8601String(),
    };
