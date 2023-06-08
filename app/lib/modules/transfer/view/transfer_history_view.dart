import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/fetch_status.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/common/components/error/error_view.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/common/components/loading/centered_activity_indicator.dart';

class TransferHistoryView extends StatelessWidget {
  const TransferHistoryView({super.key});

  static const route = '/transfer-history';

  @override
  Widget build(BuildContext context) {
    final transferHistoryStore = context.watch<TransferHistoryViewStore>();
    final dic = context.l10n;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        dic.transferHistory,
        style: context.textTheme.displayMedium,
      )),
      body: Observer(builder: (_) {
        return switch (transferHistoryStore.fetchStatus) {
          FetchStatus.loading => const CenteredActivityIndicator(),
          FetchStatus.success => TransactionsList(transactions: transferHistoryStore.transactions ?? []),
          FetchStatus.error => ErrorView(
              onRetryPressed: () {
                final appStore = context.read<AppStore>();
                context.read<TransferHistoryViewStore>().getTransfers(appStore);
              },
            ),
        };
      }),
    );
  }
}
