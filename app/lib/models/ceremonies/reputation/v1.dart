import 'dart:convert';

import 'package:encointer_wallet/utils/enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';

part 'v1.g.dart';

@JsonSerializable()
class CommunityReputationV1 {
  CommunityReputationV1(this.communityIdentifier, this.reputation);

  factory CommunityReputationV1.fromJson(Map<String, dynamic> json) => _$CommunityReputationV1FromJson(json);

  Map<String, dynamic> toJson() => _$CommunityReputationV1ToJson(this);

  CommunityIdentifier communityIdentifier;
  Reputation reputation;

  @override
  String toString() {
    return jsonEncode(this);
  }
}

// For compatibility with substrate's naming convention.
// ignore: constant_identifier_names
enum Reputation { Unverified, UnverifiedReputable, VerifiedUnlinked, VerifiedLinked }

Reputation? reputationV1FromString(String value) {
  return getEnumFromString(Reputation.values, value);
}

extension ReputationV1Extension on Reputation {
  String toValue() {
    return toEnumValue(this);
  }

  bool isVerified() {
    return this == Reputation.VerifiedUnlinked || this == Reputation.VerifiedLinked;
  }
}

/// Takes a `List<dynamic>` which contains a `List<List<[int, Map<String, dynamic>]>` and
/// transforms it into a `Map<int, CommunityReputation>`.
Map<int, CommunityReputationV1> reputationsV1FromList(List<dynamic> reputationsList) {
  final reputations = reputationsList.cast<List<dynamic>>();

  return {
    for (final cr in reputations) cr[0] as int: CommunityReputationV1.fromJson(cr[1] as Map<String, dynamic>),
  };
}
