import 'dart:convert';

import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proof_of_attendance.g.dart';

// explicit = true as we have nested Json with location
// field rename such that the fields match the ones defined in the runtime
@JsonSerializable(explicitToJson: true)
class ProofOfAttendance {
  ProofOfAttendance(
    this.proverPublic,
    this.ceremonyIndex,
    this.communityIdentifier,
    this.attendeePublic,
    this.attendeeSignature,
  );

  factory ProofOfAttendance.fromJson(Map<String, dynamic> json) => _$ProofOfAttendanceFromJson(json);
  Map<String, dynamic> toJson() => _$ProofOfAttendanceToJson(this);

  String proverPublic;
  int ceremonyIndex;
  CommunityIdentifier communityIdentifier;
  String attendeePublic;
  Map<String, String>? attendeeSignature;

  @override
  String toString() {
    return jsonEncode(this);
  }
}
