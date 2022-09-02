import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/gr_code_view/gr_code_image_view.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/service/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:encointer_wallet/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:share_plus/share_plus.dart';

class ReceivePage extends StatefulWidget {
  ReceivePage(this.store, {Key? key}) : super(key: key);
  static const String route = '/assets/receive';
  final AppStore store;

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool generateQR = false;
  late InvoiceQrCode invoice;

  PausableTimer? paymentWatchdog;
  bool observedPendingExtrinsic = false;
  int resetObservedPendingExtrinsicCounter = 0;

  @override
  void initState() {
    super.initState();

    invoice = InvoiceQrCode(
      account: widget.store.account.currentAddress,
      cid: widget.store.encointer.chosenCid,
      amount: null,
      label: widget.store.account.currentAccount.name,
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
      () async {
        if (!observedPendingExtrinsic) {
          observedPendingExtrinsic = await showSnackBarUponPendingExtrinsics(widget.store, webApi, dic);

          resetObservedPendingExtrinsicCounter = 0;
        } else {
          if (resetObservedPendingExtrinsicCounter++ > 4) {
            // Wait for 5 seconds until we check again for a pending extrinsic.
            resetObservedPendingExtrinsicCounter = 0;
            observedPendingExtrinsic = false;
          }
        }

        webApi.encointer.getAllBalances(widget.store.account.currentAddress).then((balances) {
          CommunityIdentifier? cid = widget.store.encointer.chosenCid;

          if (cid == null) {
            return;
          }

          double? demurrageRate = widget.store.encointer.community!.demurrage;
          double? newBalance = widget.store.encointer.applyDemurrage(balances[cid]);
          double oldBalance = widget.store.encointer.applyDemurrage(widget.store.encointer.communityBalanceEntry) ?? 0;
          if (newBalance != null) {
            double delta = newBalance - oldBalance;
            print('[receivePage] balance was $oldBalance, changed by $delta');
            if (delta > demurrageRate!) {
              var msg = dic.assets.incomingConfirmed
                  .replaceAll('AMOUNT', delta.toStringAsPrecision(5))
                  .replaceAll('CID_SYMBOL', widget.store.encointer.community?.metadata?.symbol ?? 'null')
                  .replaceAll('ACCOUNT_NAME', widget.store.account.currentAccount.name);
              print('[receivePage] $msg');
              widget.store.encointer.account?.addBalanceEntry(cid, balances[cid]!);
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
                  key: const Key('close-receive-page'),
                  icon: const Icon(Icons.close),
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
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: EncointerTextFormField(
                          labelText: dic.assets.invoiceAmount,
                          textStyle: Theme.of(context).textTheme.headline2!.copyWith(color: encointerBlack),
                          inputFormatters: [UI.decimalInputFormatter()],
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textFormFieldKey: const Key('invoice-amount-input'),
                          onChanged: (value) {
                            setState(() {
                              var trimmed = _amountController.text.trim();
                              if (trimmed.isNotEmpty) {
                                invoice.data.amount = double.parse(trimmed);
                              }
                            });
                          },
                          suffixIcon: const Text(
                            'ⵐ',
                            style: TextStyle(
                              color: encointerGrey,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text('${dic.profile.receiverAccount} ${widget.store.account.currentAccount.name}',
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: encointerGrey),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Enhance brightness for the QR-code
                      const WakeLockAndBrightnessEnhancer(brightness: 1),
                      QrCodeImage(
                        qrCode: invoice.toQrPayload(),
                        text: dic.assets.shareInvoice,
                        onTap: () => {
                          if (_formKey.currentState!.validate())
                            {
                              // Todo: implement invoice.toUrl()
                              Share.share(invoice.toQrPayload()),
                            }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

/// Shows a [SnackBar] if we found an extrinsic in a transaction pool addressed to the current account.
///
/// Returns a true if such an extrinsic was found.
Future<bool> showSnackBarUponPendingExtrinsics(AppStore store, Api api, Translations dic) async {
  var observedExtrinsics = false;

  try {
    var extrinsics = await api.encointer.pendingExtrinsics();

    print('[receivePage] pendingExtrinsics ${extrinsics.toString()}');
    if (extrinsics.length > 0) {
      for (var xt in extrinsics) {
        if (xt.contains(store.account.currentAccountPubKey!.substring(2))) {
          RootSnackBar.showMsg(
            dic.profile.observedPendingExtrinsic,
            durationMillis: 5000,
            textColor: Colors.black,
            backgroundColor: Colors.lightBlue,
          );
          observedExtrinsics = true;
          break;
        }
      }
    }
  } catch (e) {
    _log(e.toString());
  }

  return observedExtrinsics;
}

void _log(String msg) {
  print('[receivePage] $msg');
}
