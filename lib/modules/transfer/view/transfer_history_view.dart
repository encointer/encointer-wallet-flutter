import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    final store = context.watch<TransferHistoryStore>();
    final dic = I18n.of(context)!.translationsForLocale().home;
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.transferHistory),
      ),
      body: Observer(builder: (_) {
        if (store.transactions == null) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (store.transactions!.isEmpty) {
          return Center(child: Text(dic.noTransactions));
        } else if (store.transactions!.isNotEmpty) {
          return TransactionsList(transactions: store.transactions!);
        } else {
          return Center(child: Text(dic.unknownError));
        }
      }),
    );
  }
}

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions[index];
        return TransactionCard(transaction: transaction);
      },
    );
  }
}
