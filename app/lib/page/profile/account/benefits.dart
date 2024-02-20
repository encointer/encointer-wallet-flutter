import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/page/profile/account/faucet_list_tile.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:ew_keyring/ew_keyring.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/models/faucet/faucet.dart';
import 'package:encointer_wallet/store/app.dart';

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
    final h3Grey = context.titleLarge.copyWith(fontSize: 19, color: AppColors.encointerGrey);

    return Column(
      children: [
        Text(l10n.benefits, style: h3Grey, textAlign: TextAlign.left),
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
