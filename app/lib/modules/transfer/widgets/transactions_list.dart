import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return const TransactionsEmpty();
    final appStore = context.watch<AppStore>();
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 35),
      itemCount: transactions.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < transactions.length) {
          final transaction = transactions[index];
          return TransactionCard(transaction, appStore.settings.contactListAllToSet());
        } else if (index == transactions.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(context.l10n.transferHistoryEnd, textAlign: TextAlign.center),
          );
        }
        return const SizedBox();
      },
    );
  }
}
