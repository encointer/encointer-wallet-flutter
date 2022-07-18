import 'package:encointer_wallet/common/components/encointerTextFormField.dart';
import 'package:encointer_wallet/common/components/wakeLockAndBrightnessEnhancer.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/snackBar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:qr_flutter_fork/qr_flutter_fork.dart';

class ReceivePage extends StatefulWidget {
  ReceivePage(this.store);
  static const String route = '/assets/receive';
  final AppStore? store;
  @override
  _ReceivePageState createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _amountController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool generateQR = false;
  late InvoiceQrCode invoice;

  PausableTimer? paymentWatchdog;
  bool observedPendingExtrinsic = false;

  @override
  void initState() {
    super.initState();

    invoice = InvoiceQrCode(
      account: widget.store!.account!.currentAddress,
      cid: widget.store!.encointer!.chosenCid,
      amount: null,
      label: widget.store!.account!.currentAccount.name,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    paymentWatchdog!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    paymentWatchdog = PausableTimer(
      const Duration(seconds: 1),
      () {
        webApi!.encointer!.pendingExtrinsics().then((extrinsics) {
          print("[receivePage] pendingExtrinsics ${extrinsics.toString()}");
          if (((extrinsics.length ?? 0) > 0) && (!observedPendingExtrinsic)) {
            extrinsics.forEach((xt) {
              if (xt.contains(widget.store!.account!.currentAccountPubKey!.substring(2))) {
                RootSnackBar.showMsg(
                  dic.profile.observedPendingExtrinsic,
                  durationMillis: 5000,
                  textColor: Colors.black,
                  backgroundColor: Colors.lightBlue,
                );
                observedPendingExtrinsic = true;
              }
            });
          } else {
            observedPendingExtrinsic = false;
          }
        });
        webApi!.encointer!.getAllBalances(widget.store!.account!.currentAddress).then((balances) {
          CommunityIdentifier? cid = widget.store!.encointer!.chosenCid;

          if (cid == null) {
            return;
          }

          double? demurrageRate = widget.store!.encointer!.community!.demurrage;
          double? newBalance = widget.store!.encointer!.applyDemurrage(balances[cid]);
          double oldBalance =
              widget.store!.encointer!.applyDemurrage(widget.store!.encointer!.communityBalanceEntry) ?? 0;
          if (newBalance != null) {
            double delta = newBalance - oldBalance;
            print("[receivePage] balance was $oldBalance, changed by $delta");
            if (delta > demurrageRate!) {
              var msg = dic.assets.incomingConfirmed
                  .replaceAll('AMOUNT', delta.toStringAsPrecision(5))
                  .replaceAll('CID_SYMBOL', widget.store!.encointer!.community?.metadata?.symbol ?? "null")
                  .replaceAll('ACCOUNT_NAME', widget.store!.account!.currentAccount.name);
              print("[receivePage] $msg");
              widget.store!.encointer!.account?.addBalanceEntry(cid, balances[cid]!);
              NotificationPlugin.showNotification(44, dic.assets.fundsReceived, msg, cid: cid.toFmtString());
            }
          }
        });
        paymentWatchdog!
          ..reset()
          ..start();
      },
    )..start();

    return FocusDetector(
        onFocusLost: () {
          print('[receivePage:FocusDetector] Focus Lost.');
          paymentWatchdog!.pause();
        },
        onFocusGained: () {
          print('[receivePage:FocusDetector] Focus Gained.');
          paymentWatchdog!.reset();
          paymentWatchdog!.start();
        },
        child: Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(dic.assets.receive),
              leading: Container(),
              actions: [
                IconButton(
                  key: Key('close-receive-page'),
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Text(
                          dic.profile.qrScanHint,
                          style: Theme.of(context).textTheme.headline3!.copyWith(color: encointerBlack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: EncointerTextFormField(
                          labelText: dic.assets.invoiceAmount,
                          textStyle: Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack),
                          inputFormatters: [UI.decimalInputFormatter()],
                          controller: _amountController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          textFormFieldKey: Key('invoice-amount-input'),
                          onChanged: (value) {
                            setState(() {
                              var trimmed = _amountController.text.trim();
                              if (trimmed.isNotEmpty) {
                                invoice.data.amount = double.parse(trimmed);
                              }
                            });
                          },
                          suffixIcon: Text(
                            "ⵐ",
                            style: TextStyle(
                              color: encointerGrey,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('${dic.profile.receiverAccount} ${widget.store!.account!.currentAccount.name}',
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: encointerGrey),
                      textAlign: TextAlign.center),
                  SizedBox(height: 8),
                  Column(children: [
                    // Enhance brightness for the QR-code
                    WakeLockAndBrightnessEnhancer(brightness: 1),
                    QrImage(data: invoice.toQrPayload()),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.share, color: ZurichLion.shade500),
                              SizedBox(width: 8),
                              Text(
                                dic.assets.shareInvoice,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ]),
                      ),
                      onTap: () => {
                        if (_formKey.currentState!.validate())
                          {
                            // Todo: implement invoice.toUrl()
                            // Todo: use `share_plus` instead of discontinued `share`
                            // Share.share(invoice.toQrPayload()),
                          }
                      },
                    ),
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
