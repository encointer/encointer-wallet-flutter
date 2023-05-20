import 'package:json_annotation/json_annotation.dart';

part 'businesses.g.dart';

@JsonSerializable()
class Businesses {
  const Businesses({
    required this.name,
    required this.description,
    required this.category,
    required this.photo,
  });
  factory Businesses.fromJson(Map<String, dynamic> json) => _$BusinessesFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessesToJson(this);

  final String name;
  final String description;
  final String category;
  final String photo;
}

//category should be enum
const businessesMockData = {
  'businesses': [
    {
      'name': 'Yoga-Kurse mit Hatha Lisa',
      'description': 'Nutze deine Leu, um deinem Körper und Geist etwas Gutes zu tun. ...',
      'category': 'Body & Soul',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa.png?raw=true',
    },
    {
      'name': 'Hardi – Kafi am Tag, Kultur am Abend und zwischen ...',
      'description': 'Herzhaft unkompliziert empfängt das Hardi seine Gäste im ...',
      'category': 'Food & Beverage Store',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa-02.png?raw=true'
    },
    {
      'name': 'KAOZ',
      'description': 'Wir sind KAOZ. Das heisst: kreativ, authentisch, optimistisch und ...',
      'category': 'Fashion & Clothing',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa-02%20(1).png?raw=true'
    },
    {
      'name': 'GRRRR',
      'description': 'Papierware, Zines, Bücher, Zeichnungen aus Züri und anders...',
      'category': 'Art & Music',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa-02%20(1)%203.png?raw=true'
    },
    {
      'name': 'Sørenbrød',
      'description': 'Der Künstler Søren Berner (geb. 1977 in Dänemark) begann 1999, als er ...',
      'category': 'Food & Beverage Store',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/sorenbrod.png?raw=true'
    }
  ]
};
