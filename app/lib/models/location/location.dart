// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
import 'dart:convert';

import 'package:ew_primitives/ew_primitives.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

part 'location.g.dart';

@JsonSerializable(createFactory: false)
class Location {
  Location(this.lat, this.lon);

  // explicitly use `toString()`, which works for the old `Degree` type `i64` and the new one `i128`
  factory Location.fromJson(Map<String, dynamic> json) => Location(
        double.parse(json['lat'].toString()),
        double.parse(json['lon'].toString()),
      );

  factory Location.fromPolkadart(et.Location loc) => Location(
        latLongToDouble(loc.lat),
        latLongToDouble(loc.lon),
      );

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  final double lat;
  final double lon;

  @override
  String toString() {
    return jsonEncode(this);
  }

  String latLongFmt() {
    return 'lat=${lat.toStringAsFixed(6)},lon=${lon.toStringAsFixed(6)}';
  }

  LatLng toLatLng() {
    return LatLng(lat, lon);
  }
}
