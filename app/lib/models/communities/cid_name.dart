import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cid_name.g.dart';

/// TODO shouldn't this be named CidAndName
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CidName {
  const CidName(this.cid, this.name);

  factory CidName.fromJson(Map<String, dynamic> json) => _$CidNameFromJson(json);
  Map<String, dynamic> toJson() => _$CidNameToJson(this);

  final CommunityIdentifier cid;
  final String name;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
