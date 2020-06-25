// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claimOfAttendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimOfAttendance _$ClaimOfAttendanceFromJson(Map<String, dynamic> json) {
  return ClaimOfAttendance(
    json['claimant_public'] as String,
    json['ceremonyIndex'] as int,
    json['currency_identifier'] as String,
    json['meetupIndex'] as int,
    json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    json['timestamp'] as int,
    json['number_of_participants_confirmed'] as int,
  );
}

Map<String, dynamic> _$ClaimOfAttendanceToJson(ClaimOfAttendance instance) =>
    <String, dynamic>{
      'claimant_public': instance.claimant_public,
      'ceremonyIndex': instance.ceremonyIndex,
      'currency_identifier': instance.currency_identifier,
      'meetupIndex': instance.meetupIndex,
      'location': instance.location?.toJson(),
      'timestamp': instance.timestamp,
      'number_of_participants_confirmed':
          instance.number_of_participants_confirmed,
    };
