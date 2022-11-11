import 'package:encointer_wallet/page/assets/transfer/tx_detail.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/assets/types/transfer_data.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferDetailPage extends StatelessWidget {
  TransferDetailPage({Key? key}) : super(key: key);

  static const String route = '/assets/tx';

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    final _store = context.watch<AppStore>();
    final String? symbol = _store.settings.networkState!.tokenSymbol;
    final int? decimals = _store.settings.networkState!.tokenDecimals;
    final String tokenView = Fmt.tokenView(symbol);

    final TransferData tx = ModalRoute.of(context)!.settings.arguments as TransferData;

    final String txType = tx.from == _store.account.currentAddress ? dic.assets.transfer : dic.assets.receive;

    return TxDetail(
      success: true,
      action: txType,
      eventId: tx.extrinsicIndex,
      hash: tx.hash,
      blockTime: Fmt.dateTime(DateTime.fromMillisecondsSinceEpoch(tx.blockTimestamp! * 1000)),
      blockNum: tx.blockNum,
      networkName: _store.settings.endpoint.info,
      info: <DetailInfoItem>[
        DetailInfoItem(
          label: dic.assets.value,
          title: '${tx.amount} $tokenView',
        ),
        DetailInfoItem(
          label: dic.assets.fee,
          title: '${Fmt.balance(tx.fee, decimals, length: decimals)} $tokenView',
        ),
        DetailInfoItem(
          label: dic.assets.from,
          title: Fmt.address(tx.from),
          address: tx.from,
        ),
        DetailInfoItem(
          label: dic.assets.to,
          title: Fmt.address(tx.to),
          address: tx.to,
        )
      ],
    );
  }
}
