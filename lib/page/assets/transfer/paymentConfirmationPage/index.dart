import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/assets/transfer/paymentConfirmationPage/components/payment_overview.dart';
import 'package:encointer_wallet/page/assets/transfer/paymentConfirmationPage/components/transfer_state.dart';
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
import 'package:intl/intl.dart';

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
  TransferState _transferState = TransferState.notStarted;

  /// Transaction result, will only be used in the error case.
  Map _transactionResult;

  int _blockTimestamp;

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();
    final h2Grey = Theme.of(context).textTheme.headline2.copyWith(color: encointerGrey);
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                PaymentOverview(widget.store, params.communitySymbol, params.recipientAccount, params.amount),
                SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    "$amount ${params.communitySymbol}",
                    style: h2Grey,
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return RotationTransition(child: child, turns: animation);
                      // return ScaleTransition(child: child, scale: animation);
                    },
                    child: _getTransferStateWidget(_transferState),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: _txStateTextInfo(_transferState),
                ),
                !_transferState.isFinishedOrFailed()
                    ? PrimaryButton(
                        key: Key('make-transfer'),
                        child: Container(
                          height: 20,
                          child: !_transferState.isSubmitting()
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.send_sqaure_2),
                                    SizedBox(width: 12),
                                    Text(dic.assets.transfer),
                                  ],
                                )
                              : CupertinoActivityIndicator(),
                        ),
                        onPressed: () => _submit(context, cid, recipientAddress, amount),
                      )
                    : PrimaryButton(
                        key: Key('transfer-done'),
                        child: Container(
                          height: 20,
                          child: Text(dic.assets.done),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )
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
      _transferState = TransferState.submitting;
    });

    // var onFinish = (BuildContext txPageContext, Map res) {
    //   _log("Transfer result ${res.toString()}");
    //
    //   if (res['hash'] == null) {
    //     _log('Error sending transfer ${res['error']}');
    //     _transferState = TransferState.failed;
    //   } else {
    //     _transferState = TransferState.finished;
    //     _blockTimestamp = res['time'];
    //   }
    // };
    //
    // await submitTx(context, widget.store, widget.api, params, onFinish: onFinish);

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _transferState = TransferState.finished;
      });
    });

    _log("TransferState after callback: ${_transferState.toString()}");

    // trigger rebuild after state update in callback
    setState(() {});
  }

  Widget _getTransferStateWidget(TransferState state) {
    switch (state) {
      case TransferState.notStarted:
        {
          return Container();
        }
        break;
      case TransferState.submitting:
        {
          return SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(),
          );
        }
        break;
      case TransferState.finished:
        {
          return Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.check,
                size: 80.0,
                color: Colors.white,
              ),
            ),
          );
        }
        break;
      case TransferState.failed:
        {
          return Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.highlight_remove,
                size: 80.0,
                color: Colors.white,
              ),
            ),
          );
        }
        break;
      default:
        return Text("Unknown transfer state");
        break;
    }
  }

  Widget _txStateTextInfo(TransferState state) {
    final h2Grey = Theme.of(context).textTheme.headline2.copyWith(color: encointerGrey);
    final Translations dic = I18n.of(context).translationsForLocale();
    switch (state) {
      case TransferState.notStarted:
        {
          return Text(dic.assets.paymentDoYouWantToProceed, style: h2Grey);
        }
        break;
      case TransferState.submitting:
        {
          return Text(dic.assets.paymentSubmitting, style: h2Grey);
        }
        break;
      case TransferState.finished:
        {
          var date = DateFormat.yMd().format(DateTime.now());
          var time = DateFormat.Hms().format(DateTime.now());

          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "${dic.assets.paymentFinished}: $date\n\n",
              style: h2Grey,
              children: [
                TextSpan(
                  text: time,
                  style: h2Grey,
                ),
              ],
            ),
          );
        }
        break;
      case TransferState.failed:
        {
          return Text(
            "${dic.assets.paymentError}: ${_transactionResult['error']?.toString() ?? "Unknown Error"}",
            style: h2Grey,
          );
        }
        break;
      default:
        return Text("Unknown transfer state");
        break;
    }
  }
}

void _log(String msg) {
  print("[TxPaymentConfirmation] $msg");
}
