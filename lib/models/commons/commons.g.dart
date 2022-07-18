// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RpcMethods _$RpcMethodsFromJson(Map<String, dynamic> json) => RpcMethods(
      (json['methods'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RpcMethodsToJson(RpcMethods instance) => <String, dynamic>{
      'methods': instance.methods,
    };
