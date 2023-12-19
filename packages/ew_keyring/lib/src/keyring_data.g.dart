// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyring_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyringAccount _$KeyringAccountFromJson(Map<String, dynamic> json) => KeyringAccount(
      json['name'] as String,
      json['seed'] as String,
    );

Map<String, dynamic> _$KeyringAccountToJson(KeyringAccount instance) => <String, dynamic>{
      'name': instance.name,
      'seed': instance.seed,
    };
