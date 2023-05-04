import 'package:json_annotation/json_annotation.dart';

part 'transfer_history.g.dart';

/// A class representing an Encointer transaction.
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

  /// The block number in which the transaction was made.
  final String blockNumber;

  /// The timestamp of the transaction, in milliseconds.
  final String timestamp;

  /// The public key of the counterparty.
  final String counterParty;

  /// The amount of the transaction.
  final double amount;

  /// Determines the type of this [Transaction] based on its amount.
  /// Returns [TransactionType.outgoing] for negative amounts, and [TransactionType.incoming] for positive amounts.
  TransactionType get type => amount < 0 ? TransactionType.outgoing : TransactionType.incoming;

  /// Returns the date and time of the transaction as a [DateTime] object.
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
}

/// An enumeration of the transaction types.
enum TransactionType { outgoing, incoming }
