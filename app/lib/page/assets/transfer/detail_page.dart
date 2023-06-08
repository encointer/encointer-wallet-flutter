import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/assets/transfer/tx_detail.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/transfer_data.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class TransferDetailPage extends StatelessWidget {
  const TransferDetailPage({super.key});

  static const String route = '/assets/tx';

  @override
  Widget build(BuildContext context) {
    final dic = context.l10n;
    final store = context.watch<AppStore>();
    final symbol = store.settings.networkState!.tokenSymbol;
    final decimals = store.settings.networkState!.tokenDecimals;
    final tokenView = Fmt.tokenView(symbol);

    final tx = ModalRoute.of(context)!.settings.arguments! as TransferData;

    final txType = tx.from == store.account.currentAddress ? dic.transfer : dic.receive;

    return TxDetail(
      success: true,
      action: txType,
      eventId: tx.extrinsicIndex,
      hash: tx.hash,
      blockTime: Fmt.dateTime(DateTime.fromMillisecondsSinceEpoch(tx.blockTimestamp! * 1000)),
      blockNum: tx.blockNum,
      networkName: store.settings.endpoint.info,
      info: <DetailInfoItem>[
        DetailInfoItem(
          label: dic.value,
          title: '${tx.amount} $tokenView',
        ),
        DetailInfoItem(
          label: dic.fee,
          title: '${Fmt.balance(tx.fee, decimals, length: decimals)} $tokenView',
        ),
        DetailInfoItem(
          label: dic.from,
          title: Fmt.address(tx.from),
          address: tx.from,
        ),
        DetailInfoItem(
          label: dic.to,
          title: Fmt.address(tx.to),
          address: tx.to,
        )
      ],
    );
  }
}
