// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointer_balance_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerBalanceData _$EncointerBalanceDataFromJson(Map<String, dynamic> json) => EncointerBalanceData(
      CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
      BalanceEntry.fromJson(json['balanceEntry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EncointerBalanceDataToJson(EncointerBalanceData instance) => <String, dynamic>{
      'cid': instance.cid.toJson(),
      'balanceEntry': instance.balanceEntry.toJson(),
    };
