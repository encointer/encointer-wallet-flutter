import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/models/index.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/offline_payment/offline_payment_store.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/store/app.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.transactions,
    this.offlinePayments = const [],
    this.isOffline = false,
  });

  final List<Transaction> transactions;
  final List<OfflinePaymentRecord> offlinePayments;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty && offlinePayments.isEmpty) {
      return const TransactionsEmpty(key: Key(EWTestKeys.transactionsEmpty));
    }
    final appStore = context.watch<AppStore>();
    final offlineCount = offlinePayments.length;
    final hasOfflineBanner = isOffline ? 1 : 0;
    return ListView.builder(
      key: const Key(EWTestKeys.transactionsList),
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 35),
      itemCount: hasOfflineBanner + offlineCount + transactions.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(context.l10n.transferHistoryTop, textAlign: TextAlign.center),
          );
        }
        final adjusted = index - 1;
        if (isOffline && adjusted == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Offline — showing local payments only',
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(color: AppColors.encointerGrey),
            ),
          );
        }
        final contentIndex = adjusted - hasOfflineBanner;
        if (contentIndex < offlineCount) {
          return OfflinePaymentCard(offlinePayments[contentIndex]);
        } else if (contentIndex < offlineCount + transactions.length) {
          final transaction = transactions[contentIndex - offlineCount];
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
