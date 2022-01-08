// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encointerBalanceData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EncointerBalanceData _$EncointerBalanceDataFromJson(Map<String, dynamic> json) {
  return EncointerBalanceData(
    json['cid'] == null ? null : CommunityIdentifier.fromJson(json['cid'] as Map<String, dynamic>),
    json['balanceEntry'] == null ? null : BalanceEntry.fromJson(json['balanceEntry'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EncointerBalanceDataToJson(EncointerBalanceData instance) => <String, dynamic>{
      'cid': instance.cid?.toJson(),
      'balanceEntry': instance.balanceEntry?.toJson(),
    };

BalanceEntry _$BalanceEntryFromJson(Map<String, dynamic> json) {
  return BalanceEntry(
    (json['principal'] as num)?.toDouble(),
    json['lastUpdate'] as int,
  );
}

Map<String, dynamic> _$BalanceEntryToJson(BalanceEntry instance) => <String, dynamic>{
      'principal': instance.principal,
      'lastUpdate': instance.lastUpdate,
    };
