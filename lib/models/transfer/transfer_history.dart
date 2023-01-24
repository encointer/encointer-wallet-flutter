import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'transfer_history.g.dart';

@JsonSerializable()
class TransferHistory {
  const TransferHistory({
    required this.id,
    required this.accountData,
    required this.type,
    required this.currency,
    required this.amount,
  });

  final String id;
  final AccountData accountData;
  final TransactionType type;
  final String currency;
  final double amount;
}

enum TransactionType { expense, income }
