import 'package:json_annotation/json_annotation.dart';

part 'transfer_history.g.dart';

@JsonSerializable()
class Transaction {
  const Transaction({
    required this.id,
    required this.accountName,
    required this.accountAddress,
    required this.type,
    required this.currency,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  final String id;
  final String accountName;
  final String accountAddress;
  final TransactionType type;
  final String currency;
  final double amount;
}

enum TransactionType { outgoing, incoming }

const transferHistoryMockData = {
  'transfer_history': [
    {
      'id': '1',
      'accountName': 'John Doe',
      'accountAddress': '0x1234567890abcdef',
      'type': 'incoming',
      'currency': 'Leu',
      'amount': 0.005
    },
    {
      'id': '2',
      'accountName': 'Jane Smith',
      'accountAddress': '0x0987654321fedcba',
      'type': 'outgoing',
      'currency': 'Leu',
      'amount': 0.0125
    },
    {
      'id': '3',
      'accountName': 'Bob Johnson',
      'accountAddress': '0xabcdef0123456789',
      'type': 'incoming',
      'currency': 'Leu',
      'amount': 0.1
    }
  ]
};
