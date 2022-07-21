import 'package:encointer_wallet/common/components/AddressInputField.dart';
import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/page-encointer/common/communityChooserPanel.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/index.dart';
import 'package:encointer_wallet/page/qr_scan/qrScanPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';

class TransferPageParams {
  TransferPageParams({
    this.cid,
    this.communitySymbol,
    this.recipient,
    this.label,
    this.amount,
    this.redirect,
  });

  final CommunityIdentifier? cid;
  final String? communitySymbol;
  final String? recipient;
  final String? label;
  final double? amount;
  final String? redirect;
}

class TransferPage extends StatefulWidget {
  const TransferPage(this.store);

  static const String route = '/assets/transfer';
  final AppStore store;

  @override
  _TransferPageState createState() => _TransferPageState(store);
}

class _TransferPageState extends State<TransferPage> {
  _TransferPageState(this.store);

  final AppStore store;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountCtrl = new TextEditingController();

  AccountData? _accountTo;
  CommunityIdentifier? _cid;
  String? _communitySymbol;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    TransferPageParams params = ModalRoute.of(context)!.settings.arguments as TransferPageParams;

    _communitySymbol = params.communitySymbol;
    _cid = params.cid ?? store!.encointer!.chosenCid;

    int decimals = encointer_currencies_decimals;

    double? available = store!.encointer!.applyDemurrage(store!.encointer!.communityBalanceEntry);

    print("[transferPage]: available: $available");

    return Observer(
      builder: (_) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(dic.assets.transfer),
              leading: Container(),
              actions: [
                IconButton(
                  key: Key('close-transfer-page'),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        CombinedCommunityAndAccountAvatar(store, showCommunityNameAndAccountName: false),
                        SizedBox(height: 12),
                        store!.encointer!.communityBalance != null
                            ? AccountBalanceWithMoreDigits(store: store, available: available, decimals: decimals)
                            : CupertinoActivityIndicator(),
                        Text(
                          I18n.of(context)!
                              .translationsForLocale()
                              .assets
                              .yourBalanceFor
                              .replaceAll("ACCOUNT_NAME", Fmt.accountName(context, store!.account!.currentAccount)),
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        IconButton(
                          iconSize: 48,
                          icon: Icon(Iconsax.scan_barcode),
                          onPressed: () => Navigator.of(context).popAndPushNamed(
                            ScanPage.route,
                            arguments: ScanPageParams(scannerContext: QrScannerContext.transferPage),
                          ), // same as for clicking the scan button in the bottom bar
                        ),
                        SizedBox(height: 24),
                        EncointerTextFormField(
                          labelText: dic.assets.amountToBeTransferred,
                          textStyle: Theme.of(context).textTheme.headline1!.copyWith(color: encointerBlack),
                          inputFormatters: [UI.decimalInputFormatter(decimals: decimals)],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: _amountCtrl,
                          textFormFieldKey: Key('transfer-amount-input'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return dic.assets.amountError;
                            }
                            if (balanceTooLow(value, available!, decimals)) {
                              return dic.assets.insufficientBalance;
                            }
                            return null;
                          },
                          suffixIcon: Text("ⵐ", style: TextStyle(color: encointerGrey, fontSize: 44)),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: AddressInputField(
                                widget.store,
                                label: dic.assets.address,
                                initialValue: _accountTo,
                                onChanged: (AccountData acc) {
                                  setState(() {
                                    _accountTo = acc;
                                  });
                                },
                                hideIdenticon: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 48),
                  store!.settings!.developerMode
                      ? Center(
                          child: Text(
                            "${dic.assets.fee}: TODO compute Fee", // TODO compute fee #589
                            style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
                          ),
                        )
                      : Container(),
                  SizedBox(height: 8),
                  PrimaryButton(
                    key: Key('make-transfer'),
                    child: Container(
                      height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.login_1),
                          SizedBox(width: 12),
                          Text(dic.account.next),
                        ],
                      ),
                    ),
                    onPressed: _pushPaymentConfirmationPage,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _pushPaymentConfirmationPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        PaymentConfirmationPage.route,
        arguments: PaymentConfirmationParams(
            cid: _cid,
            communitySymbol: _communitySymbol,
            recipientAccount: _accountTo,
            amount: double.parse(_amountCtrl.text.trim())),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final TransferPageParams args = ModalRoute.of(context)!.settings.arguments as TransferPageParams;
      if (args.amount != null) {
        _amountCtrl.text = '${args.amount}';
      }

      if (args.recipient != null) {
        final AccountData acc = AccountData();
        acc.address = args.recipient!;
        acc.name = args.label!;
        setState(() {
          _accountTo = acc;
        });
      } else {
        if (widget.store!.account!.optionalAccounts.length > 0) {
          setState(() {
            _accountTo = widget.store!.account!.optionalAccounts[0];
          });
        } else if (widget.store!.settings!.contactList.length > 0) {
          setState(() {
            _accountTo = widget.store!.settings!.contactList[0];
          });
        }
      }

      webApi!.fetchAccountData();
    });
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  bool balanceTooLow(String v, double available, int decimals) {
    return double.parse(v.trim()) >= available;
  }
}

class AccountBalanceWithMoreDigits extends StatelessWidget {
  const AccountBalanceWithMoreDigits({
    Key? key,
    required this.store,
    required this.available,
    required this.decimals,
  }) : super(key: key);

  final AppStore store;
  final double? available;
  final int decimals;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        // need text base line alignment
        text: TextSpan(
          text: '${Fmt.doubleFormat(
            available,
            length: 6,
          )} ',
          style: Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack),
          children: const <TextSpan>[
            TextSpan(
              text: 'ⵐ',
              style: TextStyle(color: encointerGrey),
            ),
          ],
        ),
      ),
    );
  }
}
