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

const transferHistoryMockData = {
  'transfer_history': [
    {
      'id': '1',
      'accountName': 'John Doe',
      'accountAddress': '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW',
      'type': 'incoming',
      'currency': 'Leu',
      'amount': 0.005,
      'timestamp': 1674783247953
    },
    {
      'id': '2',
      'accountName': 'Jane Smith',
      'accountAddress': '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW',
      'type': 'outgoing',
      'currency': 'Leu',
      'amount': 0.0125,
      'timestamp': 1674783247953
    },
    {
      'id': '3',
      'accountName': 'Bob Johnson',
      'accountAddress': '5Gjvca5pwQXENZeLz3LPWsbBXRCKGeALNj1ho13EFmK1FMWW',
      'type': 'incoming',
      'currency': 'Leu',
      'amount': 0.1,
      'timestamp': 1674783247953
    }
  ]
};
