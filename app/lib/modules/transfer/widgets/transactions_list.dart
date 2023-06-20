import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return const TransactionsEmpty();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 35),
      itemCount: transactions.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < transactions.length) {
          final transaction = transactions[index];
          return TransactionCard(transaction: transaction);
        } else if (index == transactions.length) {
          final olderTransaction = DateTime.fromMillisecondsSinceEpoch(1670000000000);
          if (olderTransaction.isBefore(DateTime.timestamp())) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Loading older transactions not yet supported'),
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
