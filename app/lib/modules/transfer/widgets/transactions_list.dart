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
    if (transactions.isEmpty) return const TransactionsEmpty(key: Key('transactions-empty'));
    final appStore = context.watch<AppStore>();
    final knownAccounts = appStore.settings.knownAccounts;
    return ListView.builder(
      key: const Key('transactions-list'),
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 35),
      itemCount: transactions.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(context.l10n.transferHistoryTop, textAlign: TextAlign.center),
          );
        } else if (index <= transactions.length) {
          final transaction = transactions[index - 1];
          return TransactionCard(transaction, knownAccounts);
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(context.l10n.transferHistoryEnd, textAlign: TextAlign.center),
          );
        }
      },
    );
  }
}
