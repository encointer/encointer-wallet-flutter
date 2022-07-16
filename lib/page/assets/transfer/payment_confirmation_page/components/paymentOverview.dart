import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/material.dart';

class PaymentOverview extends StatelessWidget {
  PaymentOverview(this.store, this.communitySymbol, this.recipientAccount, this.amount);

  final AppStore store;

  final String communitySymbol;
  final AccountData recipientAccount;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final recipientLabel =
        recipientAccount.name.isNotEmpty ? recipientAccount.name : Fmt.addressOfAccount(recipientAccount, store);

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
                style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.arrow_forward_ios_outlined), SizedBox(height: 20)],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddressIcon(
                '',
                recipientAccount.pubKey,
                size: 96,
              ),
              Text(
                Fmt.address(recipientLabel),
                style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
