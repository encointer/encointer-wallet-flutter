import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/models/location/location.dart';

part 'claim_of_attendance.g.dart';

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
