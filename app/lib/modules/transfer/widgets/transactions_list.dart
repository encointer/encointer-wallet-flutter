import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) return const TransactionsEmpty(key: Key(EWTestKeys.transactionsEmpty));
    final appStore = context.watch<AppStore>();
    return ListView.builder(
      key: const Key(EWTestKeys.transactionsList),
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
          return TransactionCard(transaction, appStore.settings.knownAccounts);
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
