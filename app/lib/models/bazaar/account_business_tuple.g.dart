// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_business_tuple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountBusinessTuple _$AccountBusinessTupleFromJson(Map<String, dynamic> json) => AccountBusinessTuple(
      json['controller'] as String,
      BusinessData.fromJson(json['businessData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountBusinessTupleToJson(AccountBusinessTuple instance) => <String, dynamic>{
      'controller': instance.controller,
      'businessData': instance.businessData.toJson(),
    };
