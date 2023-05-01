import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    final transferHistoryStore = context.watch<TransferHistoryStore>();
    final dic = I18n.of(context)!.translationsForLocale().home;
    return Scaffold(
      appBar: AppBar(title: Text(dic.transferHistory)),
      body: Observer(builder: (_) {
        switch (transferHistoryStore.fetchStatus) {
          case FetchStatus.initial:
            return Center(child: Text(dic.transferHistory));
          case FetchStatus.loading:
            return const CenteredActivityIndicator();
          case FetchStatus.success:
            return TransactionsList(transactions: transferHistoryStore.transactions ?? []);
          case FetchStatus.error:
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
    final dic = I18n.of(context)!.translationsForLocale().home;
    if (transactions.isEmpty) return Center(child: Text(dic.noTransactions));
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (BuildContext context, int index) {
        final transaction = transactions[index];
        return TransactionCard(transaction: transaction);
      },
    );
  }
}
