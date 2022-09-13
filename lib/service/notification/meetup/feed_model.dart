import 'dart:convert';

Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));

String feedToJson(Feed data) => json.encode(data.toJson());

class Feed {
  Feed({
    required this.msg1,
    required this.msg2,
  });

  final Msg msg1;
  final Msg msg2;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        msg1: Msg.fromJson(json['msg-1']),
        msg2: Msg.fromJson(json['msg-2']),
      );

  Map<String, dynamic> toJson() => {
        'msg-1': msg1.toJson(),
        'msg-2': msg2.toJson(),
      };
}

class Msg {
  Msg({
    required this.title,
    required this.content,
    required this.showAt,
  });

  final String title;
  final String content;
  final DateTime showAt;

  factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        title: json['title'],
        content: json['content'],
        showAt: DateTime.parse(json['show-at']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'show-at': showAt.toIso8601String(),
      };
}
