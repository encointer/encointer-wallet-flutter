import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/page/profile/account/faucet_list_tile.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_keyring/ew_keyring.dart';

class Benefits extends StatelessWidget {
  const Benefits(
    this.store, {
    required this.faucets,
    required this.userAddress,
    super.key,
  });

  final AppStore store;

  final Address userAddress;
  final Map<String, Faucet> faucets;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final titleLarge = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);
    final titleMedium = context.titleMedium.copyWith(color: AppColors.encointerGrey);

    return Column(
      children: [
        Text('KSM ${l10n.benefits}', style: titleLarge, textAlign: TextAlign.left),
        Observer(
          builder: (_) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.balance,
                style: titleMedium,
                textAlign: TextAlign.left,
              ),
              Text(
                '${Fmt.token(store.assets.totalBalance, ertDecimals)} KSM',
                style: titleMedium,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: faucets.length,
          itemBuilder: (BuildContext context, int index) {
            final faucetPubKeyHex = faucets.keys.elementAt(index);
            return FaucetListTile(
              store,
              userAddress: userAddress.encode(),
              faucet: faucets[faucetPubKeyHex]!,
              faucetPubKey: faucetPubKeyHex,
            );
          },
        )
      ],
    );
  }
}
