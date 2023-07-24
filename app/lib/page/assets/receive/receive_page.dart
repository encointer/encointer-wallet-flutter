import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:encointer_wallet/common/components/encointer_text_form_field.dart';
import 'package:encointer_wallet/page/assets/qr_code_printing/pages/qr_code_share_or_print_view.dart';
import 'package:encointer_wallet/common/components/wake_lock_and_brightness_enhancer.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/page/qr_scan/qr_codes/index.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/notification/lib/notification.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/snack_bar.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:encointer_wallet/utils/ui.dart';

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
    _appStore = context.read<AppStore>();
    final address = Fmt.ss58Encode(_appStore.account.currentAccountPubKey!, prefix: _appStore.settings.endpoint.ss58!);
    invoice = InvoiceQrCode(
      account: address,
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
    final l10n = context.l10n;
    final store = context.watch<AppStore>();
    paymentWatchdog = PausableTimer(
      const Duration(seconds: 1),
      () async {
        if (!observedPendingExtrinsic) {
          observedPendingExtrinsic = await showSnackBarUponPendingExtrinsics(_appStore, webApi, l10n);

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
              final msg = l10n.incomingConfirmed(
                delta,
                store.encointer.community?.metadata?.symbol ?? 'null',
                store.account.currentAccount.name,
              );
              Log.d('[receivePage] $msg', 'ReceivePage');
              store.encointer.account?.addBalanceEntry(cid, balances[cid]!);

              NotificationPlugin.showNotification(44, l10n.fundsReceived, msg, cid: cid.toFmtString());
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
            title: Text(l10n.receive),
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
                      padding: const EdgeInsets.all(30),
                      child: EncointerTextFormField(
                        labelText: l10n.enterAmount,
                        textStyle: context.headlineSmall.copyWith(color: AppColors.encointerBlack),
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
                            color: AppColors.encointerGrey,
                            fontSize: 26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${l10n.receiverAccount} ${store.account.currentAccount.name}',
                  style: context.titleMedium.copyWith(color: AppColors.encointerGrey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Enhance brightness for the QR-code
                    const WakeLockAndBrightnessEnhancer(brightness: 1),
                    QrCodeShareOrPrintView(
                      qrCode: invoice.toQrPayload(),
                      shareText: l10n.shareInvoice,
                      printText: l10n.print,
                      previewText: l10n.preview,
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
Future<bool> showSnackBarUponPendingExtrinsics(AppStore store, Api api, AppLocalizations l10n) async {
  var observedExtrinsics = false;

  try {
    final extrinsics = await api.encointer.pendingExtrinsics();

    Log.d('[receivePage] pendingExtrinsics $extrinsics', 'ReceivePage');
    if (extrinsics.isNotEmpty) {
      for (final xt in extrinsics) {
        if (xt.contains(store.account.currentAccountPubKey!.substring(2))) {
          RootSnackBar.showMsg(
            l10n.observedPendingExtrinsic,
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
