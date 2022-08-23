// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
import 'dart:convert';

import "package:latlong2/latlong.dart";
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable(createFactory: false)
class Location {
  Location(this.lat, this.lon);

  final String lat;
  final String lon;

  @override
  String toString() {
    return jsonEncode(this);
  }

  LatLng toLatLng() {
    return LatLng(double.parse(lat), double.parse(lon));
  }

  // explicitly use `toString()`, which works for the old `Degree` type `i64` and the new one `i128`
  factory Location.fromJson(Map<String, dynamic> json) => Location(
        json['lat'].toString(),
        json['lon'].toString(),
      );
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
