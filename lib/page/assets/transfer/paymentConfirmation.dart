import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/tx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';


class PaymentConfirmationParams {
  PaymentConfirmationParams({
    this.cid,
    this.communitySymbol,
    this.recipientAccount,
    this.amount,
  });

  final CommunityIdentifier cid;
  final String communitySymbol;
  final AccountData recipientAccount;
  final double amount;
}

class PaymentConfirmationPage extends StatefulWidget {
  const PaymentConfirmationPage(this.store, this.api);

  static const String route = '/assets/paymentConfirmation';
  final AppStore store;
  final Api api;

  @override
  _PaymentConfirmationPageState createState() => _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  bool _submitting = false;

  bool _transferSuccess;

  int _blockTimestamp;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    PaymentConfirmationParams params = ModalRoute.of(context).settings.arguments;

    var cid = params.cid;
    var recipientAccount = params.recipientAccount;
    final recipientAddress = Fmt.addressOfAccount(recipientAccount, widget.store);
    var amount = params.amount;

    return Observer(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(dic.assets.payment)),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: ListView(children: [
                      PaymentOverview(widget.store, params.communitySymbol, params.recipientAccount, params.amount),
                  ]),
                ),
                PrimaryButton(
                  key: Key('make-transfer'),
                  child: !_submitting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.send_sqaure_2),
                            SizedBox(width: 12),
                            Text(dic.assets.transfer),
                          ],
                        )
                      : CupertinoActivityIndicator(),
                  onPressed: () => _submit(context, cid, recipientAddress, amount),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit(BuildContext context, CommunityIdentifier cid, String recipientAddress, double amount) async {
    var params = encointerBalanceTransferParams(cid, recipientAddress, amount);

    setState(() {
      _submitting = true;
    });

    var onFinish = (BuildContext txPageContext, Map res) {
      _log("Transfer result ${res.toString()}");

      if (res['hash'] == null) {
        _log('Error sending transfer ${res['error']}');
      } else {
        _blockTimestamp = res['time'];
      }
    };

    await submitTx(context, widget.store, widget.api, params, onFinish: onFinish);

    setState(() {
      _submitting = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PaymentOverview extends StatelessWidget {
  PaymentOverview(this.store, this.communitySymbol, this.recipientAccount, this.amount);

  final AppStore store;

  final String communitySymbol;
  final AccountData recipientAccount;
  final double amount;

  @override
  Widget build(BuildContext context) {

    final recipientAddress = Fmt.addressOfAccount(recipientAccount, store);

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
              children: [
                Text(
                  "$amount $communitySymbol",
                  style: Theme.of(context).textTheme.headline4.copyWith(color: encointerGrey, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined
                ),
                SizedBox(height: 45)
              ]
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
                Fmt.address(recipientAddress),
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

void _log(String msg) {
  print("[TxPaymentConfirmation] $msg");
}
