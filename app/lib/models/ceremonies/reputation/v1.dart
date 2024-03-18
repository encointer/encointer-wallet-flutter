import 'dart:convert';

import 'package:encointer_wallet/utils/enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';

part 'v1.g.dart';

@JsonSerializable()
class CommunityReputation {
  CommunityReputation(this.communityIdentifier, this.reputation);

  factory CommunityReputation.fromJson(Map<String, dynamic> json) => _$CommunityReputationFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityReputationToJson(this);

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

Reputation? reputationFromString(String value) {
  return getEnumFromString(Reputation.values, value);
}

extension ReputationExtension on Reputation {
  String toValue() {
    return toEnumValue(this);
  }

  bool isVerified() {
    return this == Reputation.VerifiedUnlinked || this == Reputation.VerifiedLinked;
  }
}

/// Takes a `List<dynamic>` which contains a `List<List<[int, Map<String, dynamic>]>` and
/// transforms it into a `Map<int, CommunityReputation>`.
Map<int, CommunityReputation> reputationsFromList(List<dynamic> reputationsList) {
  final reputations = reputationsList.cast<List<dynamic>>();

  return {
    for (final cr in reputations) cr[0] as int: CommunityReputation.fromJson(cr[1] as Map<String, dynamic>),
  };
}
