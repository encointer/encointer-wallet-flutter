import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      color: colorScheme.background,
      child: ListTile(
        minLeadingWidth: 7,
        leading: Icon(
          transaction.type == TransactionType.incoming ? Icons.call_received_sharp : Icons.call_made_sharp,
          color: transaction.type == TransactionType.incoming ? Colors.green : colorScheme.errorContainer,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaction.accountName),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${transaction.amount} '),
                  TextSpan(
                    text: transaction.currency,
                    style: textTheme.bodySmall!.copyWith(color: colorScheme.primary),
                  ),
                ],
              ),
            )
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Fmt.address(transaction.accountAddress) ?? ''),
            Text(Fmt.dateTime(DateTime.fromMillisecondsSinceEpoch(transaction.timestamp))),
          ],
        ),
      ),
    );
  }
}
