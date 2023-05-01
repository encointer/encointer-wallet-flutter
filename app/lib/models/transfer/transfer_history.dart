import 'package:json_annotation/json_annotation.dart';

part 'transfer_history.g.dart';

@JsonSerializable()
class Transaction {
  const Transaction({
    required this.blockNumber,
    required this.timestamp,
    required this.counterParty,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  final String blockNumber;
  final String timestamp;
  final String counterParty;
  final double amount;

  TransactionType get type => amount < 0 ? TransactionType.outgoing : TransactionType.incoming;
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
}

enum TransactionType { outgoing, incoming }
