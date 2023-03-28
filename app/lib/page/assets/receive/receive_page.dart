import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/common/data/substrate_api/api.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/common/components/qr_code_view/qr_code_image_view.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/snack_bar.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/extras/utils/translations/translations.dart';
import 'package:encointer_wallet/extras/utils/ui.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  static const String route = '/assets/receive';

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool generateQR = false;
  late InvoiceQrCode invoice;
  late final AppStore _appStore;

  PausableTimer? paymentWatchdog;
  bool observedPendingExtrinsic = false;
  int resetObservedPendingExtrinsicCounter = 0;

  @override
  void initState() {
    super.initState();
    _appStore = sl<AppStore>();
    invoice = InvoiceQrCode(
      account: _appStore.account.currentAddress,
      cid: _appStore.encointer.chosenCid,
      label: _appStore.account.currentAccount.name,
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
    final dic = I18n.of(context)!.translationsForLocale();
    final store = sl<AppStore>();
    paymentWatchdog = PausableTimer(
      const Duration(seconds: 1),
      () async {
        if (!observedPendingExtrinsic) {
          observedPendingExtrinsic = await showSnackBarUponPendingExtrinsics(_appStore, webApi, dic);

          resetObservedPendingExtrinsicCounter = 0;
        } else {
          if (resetObservedPendingExtrinsicCounter++ > 4) {
            // Wait for 5 seconds until we check again for a pending extrinsic.
            resetObservedPendingExtrinsicCounter = 0;
            observedPendingExtrinsic = false;
          }
        }

        await webApi.encointer.getAllBalances(store.account.currentAddress).then((balances) {
          final cid = store.encointer.chosenCid;

          if (cid == null) {
            return;
          }

          final demurrageRate = store.encointer.community!.demurrage;
          final newBalance = store.encointer.applyDemurrage(balances[cid]);
          final oldBalance = store.encointer.applyDemurrage(store.encointer.communityBalanceEntry) ?? 0;

          if (newBalance != null) {
            final delta = newBalance - oldBalance;
            Log.d('[receivePage] balance was $oldBalance, changed by $delta', 'ReceivePage');
            if (delta > demurrageRate!) {
              final msg = dic.assets.incomingConfirmed
                  .replaceAll('AMOUNT', delta.toStringAsPrecision(5))
                  .replaceAll('CID_SYMBOL', store.encointer.community?.metadata?.symbol ?? 'null')
                  .replaceAll('ACCOUNT_NAME', store.account.currentAccount.name);
              Log.d('[receivePage] $msg', 'ReceivePage');
              store.encointer.account?.addBalanceEntry(cid, balances[cid]!);

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
        Log.d('[receivePage:FocusDetector] Focus Lost.', 'ReceivePage');
        paymentWatchdog!.pause();
      },
      onFocusGained: () {
        Log.d('[receivePage:FocusDetector] Focus Gained.', 'ReceivePage');
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
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(color: encointerBlack),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: EncointerTextFormField(
                        labelText: dic.assets.invoiceAmount,
                        textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color: encointerBlack),
                        inputFormatters: [UI.decimalInputFormatter()],
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textFormFieldKey: const Key('invoice-amount-input'),
                        onChanged: (value) {
                          setState(() {
                            final trimmed = _amountController.text.trim();
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
                Text(
                  '${dic.profile.receiverAccount} ${store.account.currentAccount.name}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: encointerGrey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Enhance brightness for the QR-code
                    const WakeLockAndBrightnessEnhancer(brightness: 1),
                    QrCodeImageWithButton(
                      qrCode: invoice.toQrPayload(),
                      text: dic.assets.shareInvoice,
                      onTap: () => {
                        if (_formKey.currentState!.validate())
                          {
                            Share.share(toDeepLink(invoice.toQrPayload())),
                          }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a [SnackBar] if we found an extrinsic in a transaction pool addressed to the current account.
///
/// Returns a true if such an extrinsic was found.
Future<bool> showSnackBarUponPendingExtrinsics(AppStore store, Api api, Translations dic) async {
  var observedExtrinsics = false;

  try {
    final extrinsics = await api.encointer.pendingExtrinsics();

    Log.d('[receivePage] pendingExtrinsics $extrinsics', 'ReceivePage');
    if (extrinsics.isNotEmpty) {
      for (final xt in extrinsics) {
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
  } catch (e, s) {
    Log.e('$e', 'ReceivePage', s);
  }

  return observedExtrinsics;
}
