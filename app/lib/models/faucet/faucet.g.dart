// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faucet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faucet _$FaucetFromJson(Map<String, dynamic> json) => Faucet(
      const HexToUtf8Converter().fromJson(json['name'] as String),
      (json['purposeId'] as num).toInt(),
      (json['whitelist'] as List<dynamic>?)
          ?.map((e) => CommunityIdentifier.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['dripAmount'] as num).toInt(),
      (json['creator'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );

Map<String, dynamic> _$FaucetToJson(Faucet instance) => <String, dynamic>{
      'name': const HexToUtf8Converter().toJson(instance.name),
      'purposeId': instance.purposeId,
      'whitelist': instance.whitelist?.map((e) => e.toJson()).toList(),
      'dripAmount': instance.dripAmount,
      'creator': instance.creator,
    };
