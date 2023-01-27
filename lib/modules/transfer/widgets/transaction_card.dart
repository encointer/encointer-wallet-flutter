import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/index.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      color: colorScheme.background,
      child: ListTile(
        minLeadingWidth: 7,
        leading: Icon(
          transaction.type == TransactionType.incoming ? Icons.call_received_sharp : Icons.call_made_sharp,
          color:
              transaction.type == TransactionType.incoming ? colorScheme.primaryContainer : colorScheme.errorContainer,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaction.accountName),
            Text(transaction.currency),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaction.accountAddress),
            Text(transaction.amount.toString()),
          ],
        ),
      ),
    );
  }
}
