import 'dart:convert';

import 'package:encointer_wallet/store/encointer/types/location.dart';
import 'package:json_annotation/json_annotation.dart';

import 'communities.dart';

// Run: `flutter pub run build_runner build` in order to create/update the *.g.dart

part 'claimOfAttendance.g.dart';

// explicit = true as we have nested Json with location
@JsonSerializable(explicitToJson: true)
class ClaimOfAttendance {
  ClaimOfAttendance(this.claimantPublic, this.ceremonyIndex, this.communityIdentifier, this.meetupIndex, this.location,
      this.timestamp, this.numberOfParticipantsConfirmed);

  String? claimantPublic;
  int? ceremonyIndex;
  CommunityIdentifier? communityIdentifier;
  int? meetupIndex;
  Location? location;
  int? timestamp;
  int? numberOfParticipantsConfirmed;
  Map<String, String>? claimantSignature;

  @override
  String toString() {
    return jsonEncode(this);
  }

  factory ClaimOfAttendance.fromJson(Map<String, dynamic> json) => _$ClaimOfAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimOfAttendanceToJson(this);
}
