// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetupOverrides.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetupOverrides _$MeetupOverridesFromJson(Map<String, dynamic> json) {
  return MeetupOverrides(
    json['override-name'] as String?,
    json['network'] as String?,
    (json['communities'] as List?)?.map((e) => e as String)?.toList(),
    (json['meetup-times'] as List?)?.map((e) => e == null ? null : DateTime.parse(e as String))?.toList(),
  );
}

Map<String, dynamic> _$MeetupOverridesToJson(MeetupOverrides instance) => <String, dynamic>{
      'override-name': instance.overrideName,
      'network': instance.network,
      'communities': instance.communities,
      'meetup-times': instance.meetupTimes?.map((e) => e?.toIso8601String())?.toList(),
    };
