import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:ew_polkadart/encointer_types.dart' as et;
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

  factory ProofOfAttendance.fromPolkadart(et.ProofOfAttendance proof) {
    final sig = proof.attendeeSignature.toJson().map((key, value) => MapEntry(key, '0x${hex.encode(value)}'));
    return ProofOfAttendance(
      '0x${hex.encode(proof.proverPublic)}',
      proof.ceremonyIndex,
      CommunityIdentifier.fromPolkadart(proof.communityIdentifier),
      '0x${hex.encode(proof.attendeePublic)}',
      sig,
    );
  }

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
