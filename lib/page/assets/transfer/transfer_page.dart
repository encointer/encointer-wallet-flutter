import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/address_input_field.dart';
import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/page-encointer/common/community_chooser_panel.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/page/qr_scan/qr_scan_page.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/ui.dart';

class TransferPageParams {
  TransferPageParams({
    this.cid,
    this.communitySymbol,
    this.recipient,
    this.label,
    this.amount,
  });

  factory TransferPageParams.fromInvoiceData(InvoiceData data) {
    return TransferPageParams(
      cid: data.cid,
      recipient: data.account,
      label: data.label,
      amount: data.amount as double?,
    );
  }

  final CommunityIdentifier? cid;
  final String? communitySymbol;
  final String? recipient;
  final String? label;
  final double? amount;
}

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  static const String route = '/assets/transfer';

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountCtrl = TextEditingController();

  String? _communitySymbol;
  CommunityIdentifier? _cid;

  AccountData? _accountTo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final params = ModalRoute.of(context)!.settings.arguments as TransferPageParams?;

      final store = context.read<AppStore>();

      if (params != null) {
        handleTransferPageParams(params, store);
      } else {
        _communitySymbol = store.encointer.community!.symbol;
        _cid = store.encointer.chosenCid;
      }

      setState(() {});

      webApi.fetchAccountData();
    });
  }

  void handleTransferPageParams(TransferPageParams params, AppStore store) {
    _communitySymbol = params.communitySymbol ?? store.encointer.community!.symbol!;
    _cid = params.cid ?? store.encointer.chosenCid!;
    if (params.cid != store.encointer.chosenCid!) {
      showCupertinoDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          final dic = I18n.of(context)!.translationsForLocale().assets;
          return CupertinoAlertDialog(
            title: Text(dic.chosenRightCommunity),
          );
        },
      );
    } else {
      if (params.amount != null) {
        _amountCtrl.text = '${params.amount}';
      }

      if (params.recipient != null) {
        final acc = AccountData()
          ..address = params.recipient!
          ..name = params.label!;
        _accountTo = acc;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.watch<AppStore>();

    const decimals = encointerCurrenciesDecimals;
    final available = store.encointer.applyDemurrage(store.encointer.communityBalanceEntry);

    Log.d('[transferPage]: available: $available', 'TransferPage');

    return Observer(
      builder: (_) {
        return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(dic.assets.transfer),
              leading: const SizedBox.shrink(),
              actions: [
                if (store.settings.developerMode)
                  IconButton(
                    key: const Key('go-transfer-history'),
                    icon: const Icon(Icons.swap_vert_sharp),
                    onPressed: () {
                      Navigator.pushNamed(context, TransferHistoryView.route);
                    },
                  ),
                IconButton(
                  key: const Key('close-transfer-page'),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      key: const Key('transfer-listview'),
                      children: [
                        CombinedCommunityAndAccountAvatar(store, showCommunityNameAndAccountName: false),
                        const SizedBox(height: 12),
                        if (store.encointer.communityBalance != null)
                          AccountBalanceWithMoreDigits(
                            store: store,
                            available: available,
                            decimals: decimals,
                          )
                        else
                          const CupertinoActivityIndicator(),
                        Text(
                          I18n.of(context)!.translationsForLocale().assets.yourBalanceFor.replaceAll(
                                'ACCOUNT_NAME',
                                Fmt.accountName(context, store.account.currentAccount),
                              ),
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        IconButton(
                          iconSize: 48,
                          icon: const Icon(Iconsax.scan_barcode),
                          onPressed: () async {
                            final invoiceData = await Navigator.of(context).pushNamed(
                              ScanPage.route,
                              arguments: ScanPageParams(scannerContext: QrScannerContext.transferPage),
                            );
                            if (invoiceData != null && invoiceData is InvoiceData) {
                              handleTransferPageParams(
                                TransferPageParams.fromInvoiceData(invoiceData),
                                store,
                              );
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        EncointerTextFormField(
                          labelText: dic.assets.amountToBeTransferred,
                          textStyle: Theme.of(context).textTheme.headline1!.copyWith(color: encointerBlack),
                          inputFormatters: [UI.decimalInputFormatter()],
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          controller: _amountCtrl,
                          textFormFieldKey: const Key('transfer-amount-input'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return dic.assets.amountError;
                            }
                            if (balanceTooLow(value, available!, decimals)) {
                              return dic.assets.insufficientBalance;
                            }
                            return null;
                          },
                          suffixIcon: const Text('ⵐ', style: TextStyle(color: encointerGrey, fontSize: 44)),
                        ),
                        const SizedBox(height: 24),
                        AddressInputField(
                          store,
                          label: dic.assets.address,
                          initialValue: _accountTo,
                          onChanged: (AccountData acc) {
                            setState(() {
                              _accountTo = acc;
                            });
                          },
                          hideIdenticon: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (store.settings.developerMode)
                    Center(
                      child: Text(
                        '${dic.assets.fee}: TODO compute Fee', // TODO compute fee #589
                        style: Theme.of(context).textTheme.headline4!.copyWith(color: encointerGrey),
                      ),
                    ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    key: const Key('make-transfer'),
                    onPressed: _accountTo != null
                        ? () {
                            if (_cid != null && _communitySymbol != null) {
                              _pushPaymentConfirmationPage(_cid!, _communitySymbol!);
                            }
                          }
                        : null,
                    child: SizedBox(
                      height: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.login_1),
                          const SizedBox(width: 12),
                          Text(dic.account.next),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _pushPaymentConfirmationPage(CommunityIdentifier cid, String communitySymbol) {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        PaymentConfirmationPage.route,
        arguments: PaymentConfirmationParams(
          cid: cid,
          communitySymbol: communitySymbol,
          recipientAccount: _accountTo!,
          amount: double.parse(_amountCtrl.text.trim()),
        ),
      );
    }
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
    super.key,
    required this.store,
    required this.available,
    required this.decimals,
  });

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
