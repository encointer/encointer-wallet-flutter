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
        utf8.decode(List<int>.from(json['name'] as List<dynamic>)),
      );

  Map<String, dynamic> toJson() => _$CidNameToJson(this);

  CommunityIdentifier cid;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
