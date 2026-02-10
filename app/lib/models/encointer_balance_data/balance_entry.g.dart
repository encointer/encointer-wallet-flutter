// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceEntry _$BalanceEntryFromJson(Map<String, dynamic> json) => BalanceEntry(
      BalanceEntry._principalFromMaybeString(json['principal']),
      (json['lastUpdate'] as num).toInt(),
    );

Map<String, dynamic> _$BalanceEntryToJson(BalanceEntry instance) =>
    <String, dynamic>{
      'principal': BalanceEntry._principalToString(instance.principal),
      'lastUpdate': instance.lastUpdate,
    };
