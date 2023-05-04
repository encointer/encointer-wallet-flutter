class TestModel {
  const TestModel({
    required this.id,
    required this.title,
    required this.content,
    required this.showAt,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      showAt: json['showAt'] as String,
    );
  }

  final String id;
  final String title;
  final String content;
  final String showAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'showAt': showAt,
    };
  }
}
