// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      blockNumber: json['blockNumber'] as String,
      timestamp: json['timestamp'] as String,
      counterParty: json['counterParty'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) => <String, dynamic>{
      'blockNumber': instance.blockNumber,
      'timestamp': instance.timestamp,
      'counterParty': instance.counterParty,
      'amount': instance.amount,
    };
