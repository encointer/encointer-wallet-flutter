import 'dart:async';

import 'package:encointer_wallet/page-encointer/democracy/utils/swap_options.dart';
import 'package:encointer_wallet/service/forex/forex_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/asset_hub/asset_hub_web_api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:ew_l10n/l10n.dart';
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

  // Default selected values
  ForexRate? rate;

  // Forex service to get exchange rate of a community's local fiat to usd.
  final forexService = ForexService();

  // Controllers for text fields
  final TextEditingController amountController = TextEditingController();

  // Store errors of the text form fields. This is necessary for
  // input verification as we type.
  String? amountError;

  BigInt globalTreasuryBalance = BigInt.zero;
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
                                '${l10n.balance}: ${store.encointer.communityBalance!} ${store.encointer.community!.symbol!}')
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

  /// Ensures that the number is positive (doubles)
  String? validatePositiveNumber(String? value) {
    return validatePositiveNumberWithMax(value, null);
  }

  /// Ensures that the number is positive (doubles)
  String? validatePositiveNumberWithMax(String? value, double? max) {
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterPositiveNumber;
    } else {
      final number = double.tryParse(value);
      if (number == null || number <= 0) {
        return l10n.proposalFieldErrorPositiveNumberRange;
      } else if (max != null && number > max) {
        final maxFmt = Fmt.formatNumber(context, max, decimals: 4);
        return l10n.proposalFieldErrorPositiveNumberTooBig(maxFmt);
      } else {
        return null;
      }
    }
  }
}
