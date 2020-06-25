// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claimOfAttendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClaimOfAttendance _$ClaimOfAttendanceFromJson(Map<String, dynamic> json) {
  return ClaimOfAttendance(
    json['address'] as String,
    json['ceremonyIndex'] as int,
    json['cid'] as int,
    json['meetupIndex'] as int,
    json['loc'] == null
        ? null
        : Location.fromJson(json['loc'] as Map<String, dynamic>),
    json['time'] as int,
    json['participantCount'] as int,
  )
    ..encoding = json['encoding'] as Map<String, dynamic>
    ..meta = json['meta'] as Map<String, dynamic>;
}

Map<String, dynamic> _$ClaimOfAttendanceToJson(ClaimOfAttendance instance) =>
    <String, dynamic>{
      'address': instance.address,
      'ceremonyIndex': instance.ceremonyIndex,
      'cid': instance.cid,
      'meetupIndex': instance.meetupIndex,
      'loc': instance.loc?.toJson(),
      'time': instance.time,
      'participantCount': instance.participantCount,
      'encoding': instance.encoding,
      'meta': instance.meta,
    };
