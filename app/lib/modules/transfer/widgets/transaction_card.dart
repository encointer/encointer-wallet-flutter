import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      color: context.colorScheme.background,
      child: ListTile(
        minLeadingWidth: 7,
        leading: Icon(
          transaction.type == TransactionType.incoming ? Icons.call_received_sharp : Icons.call_made_sharp,
          color: transaction.type == TransactionType.incoming ? Colors.green : context.colorScheme.errorContainer,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(transaction.getNameFromContacts(appStore.settings.contactList) ?? ''),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '${transaction.amount} '),
                  TextSpan(
                    text: '${appStore.encointer.community?.symbol}',
                    style: context.textTheme.bodySmall!.copyWith(color: context.colorScheme.primary),
                  ),
                ],
              ),
            )
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Fmt.address(transaction.counterParty) ?? ''),
            Text(Fmt.dateTime(transaction.dateTime)),
          ],
        ),
      ),
    );
  }
}
