import 'package:encointer_wallet/page-encointer/new_bazaar/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'businesses.g.dart';

@JsonSerializable()
class Businesses {
  const Businesses({
    required this.name,
    required this.description,
    required this.category,
    this.status,
    required this.photo,
  });
  factory Businesses.fromJson(Map<String, dynamic> json) => _$BusinessesFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessesToJson(this);

  final String name;
  final String description;
  final Category category;
  final String photo;
  final Status? status;
  Color get statusColor {
    switch (status) {
      case Status.highlight:
        return const Color(0xFFE8FBFF);
      case Status.neuBeiLeu:
        return Colors.lightGreen.shade100;
      // ignore: no_default_cases
      default:
        return const Color(0xFFf4f7f8);
    }
  }
}

enum Status {
  @JsonValue('Highlight')
  highlight('Highlight', Color(0xFF00A3FF)),
  @JsonValue('Neu bei Leu')
  neuBeiLeu('Neu bei Leu', Color(0xFF00BA77));

  const Status(
    this.name,
    this.textColor,
  );
  final String name;
  final Color textColor;

  TextStyle get textStyle {
    return TextStyle(color: textColor);
  }
}

const businessesMockData = {
  'businesses': [
    {
      'name': 'Yoga-Kurse mit Hatha Lisa',
      'description': 'Nutze deine Leu, um deinem Körper und Geist etwas Gutes zu tun. ...',
      'category': 'Body & Soul',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa.png?raw=true',
      'status': 'Highlight'
    },
    {
      'name': 'Hardi – Kafi am Tag, Kultur am Abend und zwischen ...',
      'description': 'Herzhaft unkompliziert empfängt das Hardi seine Gäste im ...',
      'category': 'Food & Beverage Store',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa-02.png?raw=true',
      'status': 'Highlight'
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
      'photo':
          'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/hatha-lisa-02%20(1)%203.png?raw=true',
      'status': 'Neu bei Leu'
    },
    {
      'name': 'Sørenbrød',
      'description': 'Der Künstler Søren Berner (geb. 1977 in Dänemark) begann 1999, als er ...',
      'category': 'Food & Beverage Store',
      'photo': 'https://github.com/SourbaevaJanaraJ/lock_screen/blob/master/assets/sorenbrod.png?raw=true',
      'status': 'Neu bei Leu'
    }
  ]
};
