import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'feed_model.g.dart';

List<Feed> feedFromJson(String str) => List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));

@JsonSerializable()
class Feed {
  const Feed({
    required this.id,
    required this.title,
    required this.content,
    required this.showAt,
  });

  final String id;
  final String title;
  final String content;
  final DateTime showAt;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
  Map<String, dynamic> toJson() => _$FeedToJson(this);
}
