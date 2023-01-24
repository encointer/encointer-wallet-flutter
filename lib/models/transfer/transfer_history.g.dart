// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferHistory _$TransferHistoryFromJson(Map<String, dynamic> json) => TransferHistory(
      id: json['id'] as String,
      accountName: json['accountName'] as String,
      accountAddress: json['accountAddress'] as String,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      currency: json['currency'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$TransferHistoryToJson(TransferHistory instance) => <String, dynamic>{
      'id': instance.id,
      'accountName': instance.accountName,
      'accountAddress': instance.accountAddress,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'currency': instance.currency,
      'amount': instance.amount,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.expense: 'expense',
  TransactionType.income: 'income',
};
