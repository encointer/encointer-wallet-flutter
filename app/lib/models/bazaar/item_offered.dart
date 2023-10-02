import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'item_offered.g.dart';

/// Product metadata living in ipfs
@JsonSerializable()
class ItemOffered {
  ItemOffered(
    this.itemOffered,
    this.price,
  );

  factory ItemOffered.fromJson(Map<String, dynamic> json) => _$ItemOfferedFromJson(json);
  Map<String, dynamic> toJson() => _$ItemOfferedToJson(this);

  final String itemOffered;

  final String price;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
