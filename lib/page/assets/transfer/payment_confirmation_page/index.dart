import 'dart:async';

import 'package:animated_check/animated_check.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/components/paymentOverview.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/components/transferState.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/tx.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/store/encointer/types/communities.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
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

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> with SingleTickerProviderStateMixin {
  TransferState _transferState = TransferState.notStarted;

  /// Transaction result, will only be used in the error case.
  Map _transactionResult;

  DateTime _blockTimestamp;

  // for the animated tick.
  AnimationController _animationController;
  Animation<double> _animation;
  Timer _timer;
  bool _animationInitialized = false;

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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                PaymentOverview(widget.store, params.communitySymbol, params.recipientAccount, params.amount),
                SizedBox(height: 10),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: TextGradient(
                    text: '${Fmt.doubleFormat(amount)} ⵐ',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
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
                  flex: 2,
                  child: _txStateTextInfo(_transferState),
                ),
                !_transferState.isFinishedOrFailed()
                    ? PrimaryButton(
                        key: Key('make-transfer'),
                        child: Container(
                          height: 24,
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
                          height: 24,
                          child: Center(child: Text(dic.assets.done)),
                        ),
                        onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
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

    var onFinish = (BuildContext txPageContext, Map res) {
      _log("Transfer result ${res.toString()}");

      if (res['hash'] == null) {
        _log('Error sending transfer ${res['error']}');
        _transferState = TransferState.failed;
      } else {
        _transferState = TransferState.finished;
        _blockTimestamp = new DateTime.fromMillisecondsSinceEpoch(res['time']);
      }
    };

    await submitTx(context, widget.store, widget.api, params, onFinish: onFinish);

    // for debugging
    // Future.delayed(const Duration(milliseconds: 1500), () {
    //   setState(() {
    //     _transferState = TransferState.finished;
    //   });
    // });

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
          if (!_animationInitialized) {
            _initializeAnimation();
          }

          return Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            child: AnimatedCheck(
              progress: _animation,
              size: 100,
              color: Colors.white,
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
    final h1Grey = Theme.of(context).textTheme.headline1.copyWith(color: encointerGrey);
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
          var date = DateFormat.yMd().format(_blockTimestamp);
          var time = DateFormat.Hms().format(_blockTimestamp);

          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "${dic.assets.paymentFinished}: $date\n\n",
              style: h2Grey,
              children: [
                TextSpan(
                  text: time,
                  style: h1Grey,
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

  void _animateTick() {
    _animationController.forward();
    Future.delayed(Duration(seconds: 1), () => _animationController.reset());
  }

  void _initializeAnimation() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1)
        .animate(new CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc));

    _animationController.forward();

    _timer = Timer.periodic(
      Duration(seconds: 2),
      (_timer) => _animateTick(),
    );

    _animationInitialized = true;
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController.dispose();
      _animation = null;
      _timer.cancel();
    }
    super.dispose();
  }
}

void _log(String msg) {
  print("[TxPaymentConfirmation] $msg");
}
