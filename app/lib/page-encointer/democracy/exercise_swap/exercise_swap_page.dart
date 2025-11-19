import 'dart:async';
import 'dart:math';

import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/page-encointer/democracy/utils/field_validation.dart';
import 'package:encointer_wallet/page-encointer/democracy/utils/swap_options.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/asset_hub/asset_hub_web_api.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/theme/custom/typography/typography_theme.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:ew_l10n/l10n.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

const logTarget = 'ExerciseSwapOptionPage';

class ExerciseSwapPage extends StatefulWidget {
  const ExerciseSwapPage({super.key, required this.option});

  static const String route = '/exercise_swap';

  final SwapOption option;

  @override
  State<ExerciseSwapPage> createState() => _ExerciseSwapPageState();
}

class _ExerciseSwapPageState extends State<ExerciseSwapPage> {
  final _formKey = GlobalKey<FormState>();

  late AssetHubWebApi assetHubApi;

  // Controllers for text fields
  final TextEditingController amountController = TextEditingController();

  // Store errors of the text form fields. This is necessary for
  // input verification as we type.
  String? amountError;

  BigInt localTreasuryBalance = BigInt.zero;
  BigInt localTreasuryBalanceOnAHK = BigInt.zero;

  @override
  void initState() {
    super.initState();

    assetHubApi = AssetHubWebApi.endpoints(
      context.read<AppStore>().settings.currentNetwork.assetHubEndpoints(),
    );
    unawaited(assetHubApi.init());

    _getTreasuryBalances();
  }

  Future<void> _getTreasuryBalances() async {
    final store = context.read<AppStore>();
    final chosenCid = store.encointer.chosenCid!;

    Log.d('[getTreasuryBalances] querying data', logTarget);

    final localTreasuryAccount = await webApi.encointer.getTreasuryAccount(chosenCid);
    Log.d('[getTreasuryBalances] got encointer treasury accounts: $localTreasuryAccount', logTarget);

    await assetHubApi.ensureReady();

    final futures = await Future.wait([
      webApi.assets.getBalanceOf(localTreasuryAccount),
      if (widget.option is AssetSwap)
        assetHubApi.api
            .getForeignAssetBalanceOfEncointerAccount(localTreasuryAccount, (widget.option as AssetSwap).assetId)
    ]);

    // cast object type from futures to target type.
    final localTreasuryAccountDataOnEncointer = futures[1] as et.AccountData;
    final localTreasuryAssetBalanceOnAHK = futures[2] as BigInt;

    setState(() {
      localTreasuryBalance = localTreasuryAccountDataOnEncointer.free;
      localTreasuryBalanceOnAHK = localTreasuryAssetBalanceOnAHK;
    });
  }

  @override
  void dispose() {
    assetHubApi.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    final ccSymbol = store.encointer.community!.symbol!;
    final ccBalance = store.encointer.communityBalance!;

    final headlineSmall = context.headlineSmall;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.exerciseSwapOption),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.balance,
                              style: headlineSmall,
                            ),
                            Text(
                              '${fmt(ccBalance)} $ccSymbol',
                            ),
                            Text(
                              l10n.swapOptionAvailable,
                              style: headlineSmall,
                            ),
                            Text(l10n.swapOptionLimit(fmt(widget.option.allowance), widget.option.symbol)),
                            Text(l10n.swapOptionRate(fmt(widget.option.rate), ccSymbol, widget.option.symbol)),
                            Text(l10n.swapOptionCcLimit(fmt(widget.option.ccLimit), ccSymbol)),
                            TextFormField(
                              controller: amountController,
                              decoration: InputDecoration(
                                labelText: l10n.proposalFieldAmount(widget.option.symbol),
                                errorText: amountError,
                              ),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                // Only numbers & decimal
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                              ],
                              validator: (String? val) => validatePositiveNumber(context, val),
                              onChanged: (value) {
                                setState(() {
                                  amountError = validateAmount(value, ccBalance, treasuryBalance());
                                });
                              },
                            ),
                            Text(l10n.swapOptionCcToBeSwapped(fmt(ccToBeSwapped()), ccSymbol)),
                            const SizedBox(height: 10),
                            SubmitButton(
                              onPressed: (context) async {
                                _formKey.currentState!.validate();
                                await _submitSwap();
                              },
                              child: Text(l10n.exerciseSwapOption),
                            ),
                            treasuryBalanceTextWidget(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget treasuryBalanceTextWidget() {
    final l10n = context.l10n;

    final balance = treasuryBalance();

    return switch (widget.option) {
      NativeSwap() => Text(l10n.treasuryLocalBalance(fmt(balance))),
      AssetSwap() => Text(l10n.treasuryLocalBalanceOnAHK(
          fmt(balance),
          widget.option.symbol,
        )),
    };
  }

  double treasuryBalance() {
    final decimals = widget.option.decimals;

    final treasuryBalance = widget.option is NativeSwap
        ? Fmt.bigIntToDouble(localTreasuryBalance, decimals)
        : Fmt.bigIntToDouble(localTreasuryBalanceOnAHK, decimals);

    return treasuryBalance;
  }

  String fmt(num number) => Fmt.formatNumber(context, number, decimals: 4);

  /// Handles form submission
  Future<void> _submitSwap() async {
    if (_formKey.currentState!.validate()) {
      switch (widget.option) {
        case NativeSwap():
          await _submitSwapNative(widget.option as NativeSwap);
        case AssetSwap():
          await _submitSwapAsset(widget.option as AssetSwap);
      }
    }
  }

  Future<void> _submitSwapAsset(AssetSwap assetSwap) async {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    final amount = double.tryParse(amountController.text)!;

    await submitSwapAsset(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      store.encointer.chosenCid!,
      BigInt.from(amount * pow(10, assetSwap.decimals)),
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onError: (dispatchError) {
        final message = getLocalizedTxErrorMessage(l10n, dispatchError);
        showTxErrorDialog(context, message, false);
      },
      onFinish: (_, __) => Navigator.of(context).pop(),
    );
  }

  Future<void> _submitSwapNative(NativeSwap nativeSwap) async {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    final amount = double.tryParse(amountController.text)!;

    await submitSwapNative(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      store.encointer.chosenCid!,
      BigInt.from(amount * pow(10, nativeSwap.decimals)),
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onError: (dispatchError) {
        final message = getLocalizedTxErrorMessage(l10n, dispatchError);
        showTxErrorDialog(context, message, false);
      },
      onFinish: (_, __) => Navigator.of(context).pop(),
    );
  }

  double ccToBeSwapped() {
    final amount = amountController.text.isNotEmpty ? double.tryParse(amountController.text) : null;
    final rate = widget.option.rate;
    final ccLimit = amount != null ? amount * rate : 0.0;

    return ccLimit;
  }

  String? validateAmount(String? value, double balance, double treasuryBalance) {
    final l10n = context.l10n;

    var err = validatePositiveNumber(context, value);
    if (err != null) {
      return err;
    }

    err = validatePositiveNumberWithMax(context, value, balance);

    if (err != null) {
      return l10n.insufficientBalance;
    }

    err = validatePositiveNumberWithMax(context, value, treasuryBalance);

    if (err != null) {
      return l10n.treasuryBalanceTooLow;
    }

    return null;
  }
}
