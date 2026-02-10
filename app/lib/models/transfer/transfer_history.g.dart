// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      blockNumber: json['blockNumber'] as String,
      timestamp: json['timestamp'] as String,
      counterParty: json['counterParty'] as String,
      amount: const ShortenedDouble().fromJson(json['amount'] as num),
      foreignAssetName: json['foreignAssetName'] as String?,
      foreignAssetAmount: _$JsonConverterFromJson<num, double>(
          json['foreignAssetAmount'], const ShortenedDouble().fromJson),
      type: $enumDecodeNullable(_$SpendOrSwapEnumMap, json['type']),
      treasuryName: json['treasuryName'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'blockNumber': instance.blockNumber,
      'timestamp': instance.timestamp,
      'counterParty': instance.counterParty,
      'amount': const ShortenedDouble().toJson(instance.amount),
      'foreignAssetName': instance.foreignAssetName,
      'foreignAssetAmount': _$JsonConverterToJson<num, double>(
          instance.foreignAssetAmount, const ShortenedDouble().toJson),
      'type': _$SpendOrSwapEnumMap[instance.type],
      'treasuryName': instance.treasuryName,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$SpendOrSwapEnumMap = {
  SpendOrSwap.spend: 'Spend',
  SpendOrSwap.swap: 'Swap',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
