import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'location.g.dart';

@JsonSerializable(createFactory: false)
class Location {
  Location(this.lon, this.lat);

  final BigInt lon;
  final BigInt lat;

  @override
  String toString() {
    return jsonEncode(this);
  }

  // explicitly use `toString()`, which works for the old `Degree` type `i64` and the new one `i128`
  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(
        json['lon'] == null ? null : BigInt.parse(json['lon'].toString()),
        json['lat'] == null ? null : BigInt.parse(json['lat'].toString()),
      );
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
