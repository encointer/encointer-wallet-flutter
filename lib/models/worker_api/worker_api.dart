// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'worker_api.g.dart';

@JsonSerializable()
class PubKeyPinPair {
  PubKeyPinPair(this.pubKey, this.pin);

  factory PubKeyPinPair.fromJson(Map<String, dynamic> json) => _$PubKeyPinPairFromJson(json);
  Map<String, dynamic> toJson() => _$PubKeyPinPairToJson(this);

  String? pubKey;
  String? pin;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
