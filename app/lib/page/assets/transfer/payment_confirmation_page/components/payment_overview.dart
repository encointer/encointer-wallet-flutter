import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/format.dart';

class PaymentOverview extends StatelessWidget {
  const PaymentOverview(this.store, this.communitySymbol, this.recipientAccount, this.amount, {super.key});

  final AppStore store;

  final String? communitySymbol;
  final AccountData? recipientAccount;
  final double? amount;

  @override
  Widget build(BuildContext context) {
    final recipientLabel = recipientAccount!.name;
    final recipientAddress =
        Fmt.address(Fmt.ss58Encode(recipientAccount!.pubKey, prefix: store.settings.endpoint.ss58!))!;

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              CombinedCommunityAndAccountAvatar(store, showCommunityNameAndAccountName: false),
              Text(
                Fmt.accountName(context, store.account.currentAccount),
                style: context.bodyLarge.copyWith(color: AppColors.encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.arrow_forward_ios_outlined), SizedBox(height: 20)],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddressIcon('', recipientAccount!.pubKey),
              Text(
                recipientLabel,
                style: context.bodyLarge.copyWith(color: AppColors.encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
              Text(
                recipientAddress,
                style: context.bodyLarge.copyWith(color: AppColors.encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
