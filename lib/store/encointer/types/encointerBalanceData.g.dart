// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointerBalanceData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerBalanceData _$EncointerBalanceDataFromJson(Map<String, dynamic> json) {
  return EncointerBalanceData(
    json['cid'] as String,
    json['principal'] as num,
    json['blocknumber'] as int,
  );
}

Map<String, dynamic> _$EncointerBalanceDataToJson(
        EncointerBalanceData instance) =>
    <String, dynamic>{
      'cid': instance.cid,
      'principal': instance.principal,
      'blocknumber': instance.blocknumber,
    };
