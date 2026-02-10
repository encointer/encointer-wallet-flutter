// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_of_attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProofOfAttendance _$ProofOfAttendanceFromJson(Map<String, dynamic> json) =>
    ProofOfAttendance(
      json['proverPublic'] as String,
      (json['ceremonyIndex'] as num).toInt(),
      CommunityIdentifier.fromJson(
          json['communityIdentifier'] as Map<String, dynamic>),
      json['attendeePublic'] as String,
      (json['attendeeSignature'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$ProofOfAttendanceToJson(ProofOfAttendance instance) =>
    <String, dynamic>{
      'proverPublic': instance.proverPublic,
      'ceremonyIndex': instance.ceremonyIndex,
      'communityIdentifier': instance.communityIdentifier.toJson(),
      'attendeePublic': instance.attendeePublic,
      'attendeeSignature': instance.attendeeSignature,
    };
