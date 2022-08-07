// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointerBalanceData.dart';

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

BalanceEntry _$BalanceEntryFromJson(Map<String, dynamic> json) => BalanceEntry(
      BalanceEntry._principalFromMaybeString(json['principal']),
      json['lastUpdate'] as int,
    );

Map<String, dynamic> _$BalanceEntryToJson(BalanceEntry instance) => <String, dynamic>{
      'principal': BalanceEntry._principalToString(instance.principal),
      'lastUpdate': instance.lastUpdate,
    };
