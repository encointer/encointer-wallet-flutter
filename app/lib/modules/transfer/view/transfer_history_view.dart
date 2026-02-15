import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    final transferHistoryStore = context.watch<TransferHistoryViewStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.transferHistory),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<TransferHistoryViewStore>().getTransfers();
        },
        child: Observer(builder: (_) {
          return switch (transferHistoryStore.fetchStatus) {
            FetchStatus.loading => const CenteredActivityIndicator(),
            FetchStatus.success => TransactionsList(
                transactions: transferHistoryStore.transactions,
                offlinePayments: transferHistoryStore.offlinePayments,
                isOffline: transferHistoryStore.fetchFailed,
              ),
            FetchStatus.error => ErrorView(
                onRetryPressed: () {
                  context.read<TransferHistoryViewStore>().getTransfers();
                },
              ),
            FetchStatus.noData => const SizedBox.shrink(),
          };
        }),
      ),
    );
  }
}
