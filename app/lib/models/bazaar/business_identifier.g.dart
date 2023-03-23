// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_identifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessIdentifier _$BusinessIdentifierFromJson(Map<String, dynamic> json) =>
    BusinessIdentifier(
      json['cid'] == null
          ? null
          : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
      json['controller'] as String?,
    );

Map<String, dynamic> _$BusinessIdentifierToJson(BusinessIdentifier instance) =>
    <String, dynamic>{
      'cid': instance.cid?.toJson(),
      'controller': instance.controller,
    };
