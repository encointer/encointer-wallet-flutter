class Shop {
  final String name;
  final String description;
  final String imageHash;

  Shop({this.name, this.description, this.imageHash});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      name: json['name'],
      description: json['description'],
      imageHash: json['imageHash'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'imageHash': imageHash,
      };
}
