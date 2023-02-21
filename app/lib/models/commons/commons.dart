import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart
part 'commons.g.dart';

@JsonSerializable()
class RpcMethods {
  RpcMethods(this.methods);

  factory RpcMethods.fromJson(Map<String, dynamic> json) => _$RpcMethodsFromJson(json);
  Map<String, dynamic> toJson() => _$RpcMethodsToJson(this);

  final List<String>? methods;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
