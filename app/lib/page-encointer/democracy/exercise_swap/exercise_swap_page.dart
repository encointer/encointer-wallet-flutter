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

  // Native/Asset amount to swap into
  final TextEditingController amountController = TextEditingController();

  late AssetHubWebApi assetHubApi;

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

    final treasuryAccount = await webApi.encointer.getTreasuryAccount(chosenCid);

    await assetHubApi.ensureReady();

    final onEncointer = await webApi.assets.getBalanceOf(treasuryAccount);

    var onAHK = BigInt.zero;
    if (widget.option is AssetSwap) {
      onAHK = await assetHubApi.api.getForeignAssetBalanceOfEncointerAccount(
        treasuryAccount,
        (widget.option as AssetSwap).assetId,
      );
    }

    Log.d('[getTreasuryBalances] On Encointer ${onEncointer.free}', logTarget);
    Log.d('[getTreasuryBalances] On AH $onAHK', logTarget);

    setState(() {
      localTreasuryBalance = onEncointer.free;
      localTreasuryBalanceOnAHK = onAHK;
    });
  }

  @override
  void dispose() {
    assetHubApi.close();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<AppStore>();
    final l10n = context.l10n;
    final ccSymbol = store.encointer.community!.symbol!;
    final ccBalance = store.encointer.communityBalance!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.exerciseSwapOption),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: _buildBottomSubmit(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildBalanceCard(ccBalance, ccSymbol),
            const SizedBox(height: 16),
            _buildSwapDetailsCard(l10n, ccSymbol),
            const SizedBox(height: 16),
            _buildAmountInputCard(l10n, ccBalance),
            const SizedBox(height: 16),
            _buildToBeSwappedCard(l10n, ccSymbol),
            const SizedBox(height: 16),
            _buildTreasuryCard(l10n),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // SECTION: UI Cards
  // ────────────────────────────────────────────────

  Widget _buildBalanceCard(double ccBalance, String ccSymbol) {
    return Card(
      child: ListTile(
        title: Text(context.l10n.balance, style: context.headlineSmall),
        subtitle: Text('${fmt(ccBalance)} $ccSymbol'),
      ),
    );
  }

  Widget _buildSwapDetailsCard(AppLocalizations l10n, String ccSymbol) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.swapOption, style: context.headlineSmall),
            const SizedBox(height: 8),
            Text(l10n.swapOptionLimit(
              fmt(widget.option.allowance),
              widget.option.symbol,
            )),
            Text(l10n.swapOptionRate(
              fmt(widget.option.rate),
              ccSymbol,
              widget.option.symbol,
            )),
            Text(l10n.swapOptionCcLimit(
              fmt(widget.option.ccLimit),
              ccSymbol,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInputCard(AppLocalizations l10n, double ccBalance) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: l10n.proposalFieldAmount(widget.option.symbol),
                    errorText: amountError,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  ],
                  validator: (val) => validatePositiveNumberString(context, val),
                  onChanged: (_) {
                    setState(() {
                      amountError = validateSwapAmount(
                        amountController.text,
                        ccBalance,
                        treasuryBalance(),
                      );
                    });
                  },
                ),
              ),

              const SizedBox(width: 8),

              // ───────────────────────────────────────
              // MAX BUTTON
              // ───────────────────────────────────────
              TextButton(
                onPressed: () {
                  setState(() {
                    amountController.text = fmt(maxSwappable(ccBalance));
                    amountError = validateSwapAmount(
                      amountController.text,
                      ccBalance,
                      treasuryBalance(),
                    );
                  });
                },
                child: const Text('Max'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToBeSwappedCard(AppLocalizations l10n, String ccSymbol) {
    return Card(
      child: ListTile(
        title: Text(
          l10n.swapOptionCcToBeSwapped(fmt(ccToBeSwapped()), ccSymbol),
        ),
      ),
    );
  }

  Widget _buildTreasuryCard(AppLocalizations l10n) {
    final balance = treasuryBalance();

    return Card(
      child: ListTile(
        title: switch (widget.option) {
          NativeSwap() => Text(
              l10n.treasuryLocalBalance(fmt(balance)),
            ),
          AssetSwap() => Text(
              l10n.treasuryLocalBalanceOnAHK(
                fmt(balance),
                widget.option.symbol,
              ),
            ),
        },
      ),
    );
  }

  // ────────────────────────────────────────────────
  // SECTION: Bottom Submit Button
  // ────────────────────────────────────────────────

  Widget _buildBottomSubmit() {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16), // ← bottom = 8
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SubmitButton(
            onPressed: (context) async {
              if (_formKey.currentState!.validate()) {
                await _submitSwap();
              }
            },
            child: Text(l10n.exerciseSwapOption),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  // SECTION: Logic
  // ────────────────────────────────────────────────

  double treasuryBalance() {
    final decimals = widget.option.decimals;

    if (widget.option is NativeSwap) {
      return Fmt.bigIntToDouble(localTreasuryBalance, decimals);
    } else {
      return Fmt.bigIntToDouble(localTreasuryBalanceOnAHK, decimals);
    }
  }

  String fmt(num number) => Fmt.formatNumber(context, number, decimals: 4);

  double ccToBeSwapped() {
    final amount = double.tryParse(amountController.text) ?? 0;
    return amount * widget.option.rate;
  }

  double maxSwappable(double ccBalance) {
    // We first check the max that we could get with our balance
    // and give some slack.
    final maxTargetSwap = ccBalance * 0.98 / widget.option.rate;

    // But we still need to cap it at the max treasury balance
    final available = min(maxTargetSwap, treasuryBalance());

    // finally, we need to respect the SwapOptions limit
    return min(available, widget.option.allowance);
  }

  String? validateSwapAmount(
    String? swapTargetValue,
    double accountBalance,
    double treasuryBalance,
  ) {
    final l10n = context.l10n;

    final e1 = validatePositiveNumberString(context, swapTargetValue);
    if (e1 != null) return e1;

    final swapTargetInCC = double.parse(swapTargetValue!) * widget.option.rate;

    final e2 = validatePositiveNumberWithMax(context, swapTargetInCC, accountBalance);
    if (e2 != null) return l10n.insufficientBalance;

    final e3 = validatePositiveNumberWithMax(context, swapTargetInCC, treasuryBalance);
    if (e3 != null) return l10n.treasuryBalanceTooLow;

    return null;
  }

  Future<void> _submitSwap() async {
    switch (widget.option) {
      case NativeSwap():
        await _submitSwapNative(widget.option as NativeSwap);
      case AssetSwap():
        await _submitSwapAsset(widget.option as AssetSwap);
    }
  }

  Future<void> _submitSwapAsset(AssetSwap assetSwap) async {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    final amount = double.parse(amountController.text);

    await submitSwapAsset(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      store.encointer.chosenCid!,
      BigInt.from(amount * pow(10, assetSwap.decimals)),
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onError: (err) {
        showTxErrorDialog(context, getLocalizedTxErrorMessage(l10n, err), false);
      },
      onFinish: (_, __) => Navigator.pop(context),
    );
  }

  Future<void> _submitSwapNative(NativeSwap nativeSwap) async {
    final store = context.read<AppStore>();
    final l10n = context.l10n;
    final amount = double.parse(amountController.text);

    await submitSwapNative(
      context,
      store,
      webApi,
      store.account.getKeyringAccount(store.account.currentAccountPubKey!),
      store.encointer.chosenCid!,
      BigInt.from(amount * pow(10, nativeSwap.decimals)),
      txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      onError: (err) {
        showTxErrorDialog(context, getLocalizedTxErrorMessage(l10n, err), false);
      },
      onFinish: (_, __) => Navigator.pop(context),
    );
  }
}
