import 'dart:async';

import 'package:animated_check/animated_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/config.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/repository_provider.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/components/payment_overview.dart';
import 'package:encointer_wallet/page/assets/transfer/payment_confirmation_page/components/transfer_state.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class PaymentConfirmationParams {
  PaymentConfirmationParams({
    required this.cid,
    required this.communitySymbol,
    required this.recipientAccount,
    required this.amount,
  });

  final CommunityIdentifier cid;
  final String communitySymbol;
  final AccountData recipientAccount;
  final double amount;
}

class PaymentConfirmationPage extends StatefulWidget {
  const PaymentConfirmationPage(this.api, {super.key});

  static const String route = '/assets/paymentConfirmation';
  final Api api;

  @override
  State<PaymentConfirmationPage> createState() => _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> with SingleTickerProviderStateMixin {
  TransferState _transferState = TransferState.notStarted;

  /// Transaction result, will only be used in the error case.
  late Map _transactionResult;

  late DateTime _blockTimestamp;

  // for the animated tick.
  AnimationController? _animationController;
  Animation<double>? _animation;
  late Timer _timer;
  bool _animationInitialized = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();
    final params = ModalRoute.of(context)!.settings.arguments! as PaymentConfirmationParams;

    final cid = params.cid;
    final recipientAccount = params.recipientAccount;
    final amount = params.amount;
    final recipientAddress = Fmt.ss58Encode(recipientAccount.pubKey, prefix: store.settings.endpoint.ss58!);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.payment)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: [
            PaymentOverview(
              context.watch<AppStore>(),
              params.communitySymbol,
              params.recipientAccount,
              params.amount,
            ),
            const SizedBox(height: 10),
            Flexible(
              fit: FlexFit.tight,
              child: TextGradient(
                text: '${Fmt.doubleFormat(amount)} ⵐ',
                style: const TextStyle(fontSize: 60),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(turns: animation, child: child);
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
            if (!_transferState.isFinishedOrFailed())
              PrimaryButton(
                key: const Key('make-transfer-send'),
                onPressed: () {
                  LoginDialog.askPin(context, onSuccess: (v) async {
                    await _submit(context, cid, recipientAddress, amount);
                  });
                },
                child: SizedBox(
                  height: 24,
                  child: !_transferState.isSubmitting()
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Iconsax.send_sqaure_2),
                            const SizedBox(width: 12),
                            Text(l10n.transfer),
                          ],
                        )
                      : const CupertinoActivityIndicator(),
                ),
              )
            else
              PrimaryButton(
                key: const Key('transfer-done'),
                child: SizedBox(
                  height: 24,
                  child: Center(child: Text(l10n.done)),
                ),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              )
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context, CommunityIdentifier cid, String recipientAddress, double? amount) async {
    final params = encointerBalanceTransferParams(cid, recipientAddress, amount, context.l10n);

    setState(() {
      _transferState = TransferState.submitting;
    });

    void onFinish(BuildContext txPageContext, Map res) {
      Log.d('Transfer result $res', 'PaymentConfirmationPage');

      if (res['hash'] == null) {
        Log.d('Error sending transfer ${res['error']}', 'PaymentConfirmationPage');
        _transferState = TransferState.failed;
      } else {
        _transferState = TransferState.finished;
        _blockTimestamp = DateTime.fromMillisecondsSinceEpoch(res['time'] as int);
      }
    }

    await submitTx(context, context.read<AppStore>(), widget.api, params, onFinish: onFinish);

    // for debugging
    // Future.delayed(const Duration(milliseconds: 1500), () {
    //   setState(() {
    //     _transferState = TransferState.finished;
    //   });
    // });

    Log.d('TransferState after callback: $_transferState', 'PaymentConfirmationPage');
    // trigger rebuild after state update in callback
    setState(() {});
  }

  Widget _getTransferStateWidget(TransferState state) {
    switch (state) {
      case TransferState.notStarted:
        return Container();
      case TransferState.submitting:
        return const SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(),
        );
      case TransferState.finished:
        {
          if (!_animationInitialized) {
            _initializeAnimation();
          }

          return DecoratedBox(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            child: AnimatedCheck(
              progress: _animation!,
              size: 100,
              color: Colors.white,
            ),
          );
        }
      case TransferState.failed:
        return const DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.highlight_remove,
              size: 80,
              color: Colors.white,
            ),
          ),
        );
    }
  }

  Widget _txStateTextInfo(TransferState state) {
    final h1Grey = context.textTheme.displayLarge!.copyWith(color: AppColors.encointerGrey);
    final h2Grey = context.textTheme.displayMedium!.copyWith(color: AppColors.encointerGrey);

    final l10n = context.l10n;
    switch (state) {
      case TransferState.notStarted:
        {
          return Text(l10n.paymentDoYouWantToProceed, style: h2Grey);
        }
      case TransferState.submitting:
        {
          return Text(l10n.paymentSubmitting, style: h2Grey);
        }
      case TransferState.finished:
        {
          final date = DateFormat.yMd().format(_blockTimestamp);
          final time = DateFormat.Hms().format(_blockTimestamp);

          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '${l10n.paymentFinished}: $date\n\n',
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
      case TransferState.failed:
        {
          return Text(
            "${l10n.paymentError}: ${_transactionResult['error']?.toString() ?? "Unknown Error"}",
            style: h2Grey,
          );
        }
    }
  }

  void _animateTick() {
    if (!RepositoryProvider.of<AppConfig>(context).isIntegrationTest) {
      _animationController!.forward();
      Future.delayed(const Duration(seconds: 1), () => _animationController!.reset());
    }
  }

  void _initializeAnimation() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animationController!, curve: Curves.easeInOutCirc));

    _animationController!.forward();

    _timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) => _animateTick(),
    );

    _animationInitialized = true;
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
      _animation = null;
      _timer.cancel();
    }
    super.dispose();
  }
}
