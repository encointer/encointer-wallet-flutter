import 'package:encointer_wallet/common/components/address_icon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/material.dart';

class PaymentOverview extends StatelessWidget {
  const PaymentOverview(this.store, this.communitySymbol, this.recipientAccount, this.amount, {super.key});

  final AppStore store;

  final String? communitySymbol;
  final AccountData? recipientAccount;
  final double? amount;

  @override
  Widget build(BuildContext context) {
    final recipientLabel =
        recipientAccount!.name.isNotEmpty ? recipientAccount!.name : Fmt.addressOfAccount(recipientAccount!, store);

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CombinedCommunityAndAccountAvatar(store, showCommunityNameAndAccountName: false),
              Text(
                Fmt.accountName(context, store.account.currentAccount),
                style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Icon(Icons.arrow_forward_ios_outlined), SizedBox(height: 20)],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddressIcon(
                '',
                recipientAccount!.pubKey,
                size: 96,
              ),
              Text(
                Fmt.address(recipientLabel)!,
                style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
