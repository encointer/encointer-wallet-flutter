// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyring_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyringAccountData _$KeyringAccountDataFromJson(Map<String, dynamic> json) => KeyringAccountData(
      json['name'] as String,
      json['uri'] as String,
      json['pubKey'] as String,
    );

Map<String, dynamic> _$KeyringAccountDataToJson(KeyringAccountData instance) => <String, dynamic>{
      'name': instance.name,
      'uri': instance.uri,
      'pubKey': instance.pubKey,
    };
