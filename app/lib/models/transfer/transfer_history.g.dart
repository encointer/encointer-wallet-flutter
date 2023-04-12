// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as String,
      accountName: json['accountName'] as String,
      accountAddress: json['accountAddress'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      currency: json['currency'] as String,
      amount: (json['amount'] as num).toDouble(),
      timestamp: json['timestamp'] as int,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountName': instance.accountName,
      'accountAddress': instance.accountAddress,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'currency': instance.currency,
      'amount': instance.amount,
      'timestamp': instance.timestamp,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.outgoing: 'outgoing',
  TransactionType.incoming: 'incoming',
};
