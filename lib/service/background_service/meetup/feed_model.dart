import 'dart:convert';

List<Feed> feedFromJson(String str) => List<Feed>.from(json.decode(str).map((x) => Feed.fromJson(x)));

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

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        showAt: DateTime.parse(json['show-at']),
      );
}
