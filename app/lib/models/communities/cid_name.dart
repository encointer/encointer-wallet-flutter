import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cid_name.g.dart';

/// TODO shouldn't this be named CidAndName
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CidName {
  CidName(this.cid, this.name);

  factory CidName.fromJson(Map<String, dynamic> json) => CidName(
        CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
        parseListIntOrReturnInput(json['name'] as String),
      );

  Map<String, dynamic> toJson() => _$CidNameToJson(this);

  CommunityIdentifier cid;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

/// For some reason JS returns: 1,2,4,3,5,6 as a String. However if `input` doesn't contain a comma, we assume that
/// the input is valid, which could happen at some point after a JS upgrade.
///
/// This function parses the individual numbers into a List<int>.
String parseListIntOrReturnInput(String input) {
  // Split the string by commas
  final stringValues = input.split(',');

  if (stringValues.length < 2) {
    // assume that the input is already a valid name.
    return input;
  }

  // Parse and convert to integers
  final result = <int>[];
  for (final stringValue in stringValues) {
    final intValue = int.tryParse(stringValue.trim()); // Trim to remove leading/trailing whitespace
    if (intValue != null) {
      result.add(intValue);
    }
  }

  return utf8.decode(result);
}
