import 'dart:convert';

import 'package:encointer_wallet/utils/enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';

part 'v2.g.dart';

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

abstract class Reputation {
  const Reputation();

  factory Reputation.fromJson(dynamic json) {
    if (json.runtimeType is String) {
      final variant = json as String;
      switch (variant) {
        case 'Unverified':
          return const Unverified();
        case 'UnverifiedReputable':
          return const UnverifiedReputable();
        case 'VerifiedUnlinked':
          return const VerifiedUnlinked();
        default:
          throw Exception('Reputation: Invalid variant: "$variant"');
      }
    } else if (json.runtimeType is Map<String, dynamic>) {
      final variant = (json as Map<String, dynamic>).keys.first;
      switch (variant) {
        case 'VerifiedLinked':
          return VerifiedLinked(json.values.first as int);
        default:
          throw Exception('Reputation: Invalid variant: "$variant"');
      }
    } else {
      throw Exception('Reputation: Invalid json type: "$json"');
    }
  }

  static const $Reputation values = $Reputation();

  Map<String, dynamic> toJson();
}

class $Reputation {
  const $Reputation();

  Unverified unverified() {
    return const Unverified();
  }

  UnverifiedReputable unverifiedReputable() {
    return const UnverifiedReputable();
  }

  VerifiedUnlinked verifiedUnlinked() {
    return const VerifiedUnlinked();
  }

  VerifiedLinked verifiedLinked(int value0) {
    return VerifiedLinked(value0);
  }
}

class Unverified extends Reputation {
  const Unverified();

  @override
  Map<String, dynamic> toJson() => {'Unverified': null};

  @override
  bool operator ==(Object other) => other is Unverified;

  @override
  int get hashCode => runtimeType.hashCode;
}

class UnverifiedReputable extends Reputation {
  const UnverifiedReputable();

  @override
  Map<String, dynamic> toJson() => {'UnverifiedReputable': null};

  @override
  bool operator ==(Object other) => other is UnverifiedReputable;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerifiedUnlinked extends Reputation {
  const VerifiedUnlinked();

  @override
  Map<String, dynamic> toJson() => {'VerifiedUnlinked': null};

  @override
  bool operator ==(Object other) => other is VerifiedUnlinked;

  @override
  int get hashCode => runtimeType.hashCode;
}

class VerifiedLinked extends Reputation {
  const VerifiedLinked(this.value0);

  /// CeremonyIndexType
  final int value0;

  @override
  Map<String, int> toJson() => {'VerifiedLinked': value0};

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VerifiedLinked && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

extension ReputationExtension on Reputation {
  String toValue() {
    return toEnumValue(this);
  }

  bool isVerified() {
    return runtimeType == VerifiedUnlinked || runtimeType == VerifiedLinked;
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
