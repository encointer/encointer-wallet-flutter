import 'dart:async';
import 'dart:math';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/common/components/address_input_field.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/config/consts.dart';
import 'package:encointer_wallet/models/communities/community_identifier.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/asset_id.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/exchange_rate.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/helpers.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/utf8_limited_byte_field.dart';
import 'package:encointer_wallet/service/forex/forex_service.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/substrate_api/asset_hub/asset_hub_web_api.dart';
import 'package:encointer_wallet/service/tx/lib/src/error_notifications.dart';
import 'package:encointer_wallet/service/tx/lib/src/submit_to_inner.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/theme/custom/typography/typography_theme.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:ew_primitives/ew_primitives.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:ew_polkadart/encointer_types.dart' as et;

import 'package:ew_polkadart/ew_polkadart.dart'
    show
        AddLocation,
        IssueSwapNativeOption,
        Petition,
        ProposalAction,
        SetInactivityTimeout,
        SpendNative,
        SpendAsset,
        UpdateDemurrage,
        UpdateNominalIncome,
        SwapNativeOption,
        SwapAssetOption,
        IssueSwapAssetOption;

const logTarget = 'ProposePage';

class ProposePage extends StatefulWidget {
  const ProposePage({super.key});

  static const String route = '/propose';

  @override
  State<ProposePage> createState() => _ProposePageState();
}

class _ProposePageState extends State<ProposePage> {
  final _formKey = GlobalKey<FormState>();

  static const maxTreasuryPayoutFraction = 0.1;

  late AssetHubWebApi assetHubApi;

  // Default selected values
  ProposalActionIdentifier selectedAction = ProposalActionIdentifier.petition;
  late ProposalScope selectedScope;
  List<ProposalScope> allowedScopes = [];
  AssetToSpend selectedAsset = AssetToSpend.usdc;
  ForexRate? rate;

  // Forex service to get exchange rate of a community's local fiat to usd.
  final forexService = ForexService();

  // Controllers for text fields
  final TextEditingController latController = TextEditingController();
  final TextEditingController lonController = TextEditingController();
  final TextEditingController demurrageController = TextEditingController();
  final TextEditingController nominalIncomeController = TextEditingController();
  final TextEditingController inactivityTimeoutController = TextEditingController();
  final TextEditingController petitionTextController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController allowanceController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  // Store errors of the text form fields. This is necessary for
  // input verification as we type.
  String? latError;
  String? lonError;
  String? demurrageError;
  String? nominalIncomeError;
  String? inactivityTimeoutError;
  String? petitionError;
  String? amountError;
  String? allowanceError;
  String? rateError;

  // Beneficiary in for the spendNative/issueSwapNativeOption
  AccountData? beneficiary;

  List<ProposalActionIdWithScope> enactmentQueue = [];
  BigInt globalTreasuryBalance = BigInt.zero;
  BigInt localTreasuryBalance = BigInt.zero;
  BigInt localTreasuryBalanceOnAHK = BigInt.zero;

  BigInt pendingGlobalSpends = BigInt.zero;
  BigInt pendingLocalSpends = BigInt.zero;

  Map<AssetToSpend, BigInt> swapAssetOptions = {
    AssetToSpend.usdc: BigInt.zero,
  };
  Map<AssetToSpend, BigInt> pendingSwapAssetOptions = {
    AssetToSpend.usdc: BigInt.zero,
  };
  Map<AssetToSpend, BigInt> pendingAssetSpends = {
    AssetToSpend.usdc: BigInt.zero,
  };

  @override
  void initState() {
    super.initState();

    assetHubApi = AssetHubWebApi.endpoints(
      context.read<AppStore>().settings.currentNetwork.assetHubEndpoints(),
    );
    unawaited(assetHubApi.init());

    _updateAllowedScopes();
    _updateEnactmentQueue();
    _updateExchangeRate();

    beneficiary = context.read<AppStore>().account.currentAccount;
  }

  /// Updates the allowed scope options and resets the selectedScope
  void _updateAllowedScopes() {
    setState(() {
      allowedScopes = selectedAction.allowedPolicies();
      selectedScope = allowedScopes.first; // Default to the first allowed scope
    });
  }

  Future<void> _updateExchangeRate() async {
    final store = context.read<AppStore>();
    final symbol = store.encointer.community!.symbol!;

    if (isKnownCommunity(symbol)) {
      final knowCommunity = knownCommunityFromMetadata(symbol);
      final fiat = knowCommunity.localFiatCurrency;
      final forexRate = await forexService.getUsdRate(fiat);
      Log.d('[updateExchangeRate] got forex exchange rate usd->$fiat: ${forexRate?.value}');
      setState(() {
        rate = forexRate;
      });
    } else {
      Log.d('[updateExchangeRate] Will not fetch exchange rate for not well-known community $symbol');
    }
  }

  Future<void> _updateEnactmentQueue() async {
    final store = context.read<AppStore>();
    final chosenCid = store.encointer.chosenCid!;

    Log.d('[updateEnactmentQueue] querying data', logTarget);

    final treasuryAccounts =
        await Future.wait([webApi.encointer.getTreasuryAccount(null), webApi.encointer.getTreasuryAccount(chosenCid)]);

    final globalTreasuryAccount = treasuryAccounts[0];
    final localTreasuryAccount = treasuryAccounts[1];
    Log.d('[updateEnactmentQueue] got encointer treasury accounts: $treasuryAccounts', logTarget);

    await assetHubApi.ensureReady();

    final futures = await Future.wait([
      webApi.encointer.getProposalEnactmentQueue(),
      webApi.assets.getBalanceOf(globalTreasuryAccount),
      webApi.assets.getBalanceOf(localTreasuryAccount),
      assetHubApi.api.getForeignAssetBalanceOfEncointerAccount(localTreasuryAccount, selectedAsset.assetId),
      webApi.encointer.getSwapNativeOptions(chosenCid),
      webApi.encointer.getSwapAssetOptions(chosenCid)
    ]);

    // cast object type from futures to target type.
    final queuedProposalIds = futures[0] as List<BigInt>;
    final globalTreasuryAccountDataOnEncointer = futures[1] as et.AccountData;
    final localTreasuryAccountDataOnEncointer = futures[2] as et.AccountData;
    final localTreasuryAssetBalanceOnAHK = futures[3] as BigInt;
    final swapNativeOptions = futures[4] as List<et.SwapNativeOption>;
    final swapAssetOptions = futures[5] as List<et.SwapAssetOption>;

    // Get all open swaps for this community
    final openSwapNativeAmount = swapNativeOptions.fold(BigInt.zero, (sum, swap) => sum + swap.nativeAllowance);

    for (final assetOption in swapAssetOptions) {
      final asset = fromVersionedLocatableAsset(assetOption.assetId);
      Log.d('[updateEnactmentQueue] found swap asset option: ${assetOption.toJson()}', logTarget);
      this.swapAssetOptions[asset] = (this.swapAssetOptions[asset] ?? BigInt.zero) + assetOption.assetAllowance;
    }

    var globalSpends = BigInt.zero;
    var localSpends = BigInt.zero;

    final queuedProposals = await webApi.encointer.getProposals(queuedProposalIds);

    // Get pending spends from queued SpendNative and IssueSwapNativeOption proposals.
    for (final proposal in queuedProposals.values) {
      final action = proposal.action;
      if (action is SpendNative) {
        if (action.value0 == null) {
          globalSpends += action.value2;
        } else {
          final cid = CommunityIdentifier.fromPolkadart(action.value0!);
          if (cid == store.encointer.chosenCid!) {
            localSpends += action.value2;
          }
        }
      } else if (action is IssueSwapNativeOption) {
        localSpends += action.value2.nativeAllowance;
      } else if (action is SpendAsset) {
        final asset = fromVersionedLocatableAsset(action.value3);
        if (action.value0 == null) {
          // Currently we do not have a global asset spend proposal.
        } else {
          final cid = CommunityIdentifier.fromPolkadart(action.value0!);
          if (cid == store.encointer.chosenCid!) {
            Log.d('[updateEnactmentQueue] pending SpendAsset: ${action.toJson()}', logTarget);
            pendingAssetSpends[asset] = (pendingAssetSpends[asset] ?? BigInt.zero) + action.value2;
          }
        }
      } else if (action is IssueSwapAssetOption) {
        final asset = fromVersionedLocatableAsset(action.value2.assetId);
        final cid = CommunityIdentifier.fromPolkadart(action.value0);
        if (cid == store.encointer.chosenCid!) {
          Log.d('[updateEnactmentQueue] pending spend SwapAssetOption: ${action.toJson()}', logTarget);
          pendingSwapAssetOptions[asset] =
              (pendingSwapAssetOptions[asset] ?? BigInt.zero) + action.value2.assetAllowance;
        }
      }
    }

    setState(() {
      enactmentQueue = queuedProposals.values
          .map<ProposalActionIdWithScope>((a) => ProposalActionIdWithScope.fromProposalAction(a.action))
          .toList();
      globalTreasuryBalance = globalTreasuryAccountDataOnEncointer.free;
      localTreasuryBalance = localTreasuryAccountDataOnEncointer.free;
      localTreasuryBalanceOnAHK = localTreasuryAssetBalanceOnAHK;

      pendingGlobalSpends = globalSpends;
      pendingLocalSpends = localSpends + openSwapNativeAmount;
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
        title: Text(l10n.proposalNew),
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
                        // Proposal Action Selector
                        DropdownButtonFormField<ProposalActionIdentifier>(
                          initialValue: selectedAction,
                          onChanged: (ProposalActionIdentifier? newValue) {
                            setState(() {
                              selectedAction = newValue!;
                              _updateAllowedScopes();
                            });
                          },
                          items: supportedProposalIds().map((ProposalActionIdentifier action) {
                            return DropdownMenuItem<ProposalActionIdentifier>(
                              value: action,
                              child: Text(action.localizedStr(l10n, store.encointer.community!.symbol!, selectedAsset)),
                            );
                          }).toList(),
                          decoration: InputDecoration(labelText: l10n.proposalType),
                        ),

                        const SizedBox(height: 10),

                        // Scope Selector
                        DropdownButtonFormField<ProposalScope>(
                          initialValue: selectedScope,
                          onChanged: allowedScopes.length > 1
                              ? (ProposalScope? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedScope = newValue;
                                    });
                                  }
                                }
                              : null, // Disable dropdown if only one option
                          items: allowedScopes.map((ProposalScope scope) {
                            return DropdownMenuItem<ProposalScope>(
                              value: scope,
                              child: Text(scope.localizedStr(l10n, store.encointer.community!.name!)),
                            );
                          }).toList(),
                          decoration: InputDecoration(labelText: l10n.proposalScope),
                        ),

                        const SizedBox(height: 10),

                        // Dynamic Fields Based on Selected Proposal Action
                        _buildDynamicFields(context),
                        const SizedBox(height: 10),
                        _getProposalExplainer(context),

                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...maybeShowTreasuryBalances(context),

                            // Hint text for accounts without reputation

                            if (!isBootstrapperOrReputable(store, store.account.currentAddress))
                              Text(l10n.proposalOnlyBootstrappersOrReputablesCanSubmit, textAlign: TextAlign.center),
                            if (hasSameProposalForSameScope(enactmentQueue, selectedAction,
                                selectedScope.isLocal ? store.encointer.chosenCid! : null))
                              Text(l10n.proposalCannotSubmitProposalTypePendingEnactment, textAlign: TextAlign.center),

                            // Submit button

                            const SizedBox(height: 5),
                            SubmitButton(
                              onPressed: isBootstrapperOrReputable(store, store.account.currentAddress) &&
                                      !hasSameProposalForSameScope(enactmentQueue, selectedAction,
                                          selectedScope.isLocal ? store.encointer.chosenCid! : null)
                                  ? (context) async {
                                      _formKey.currentState!.validate();
                                      await _submitProposal();
                                    }
                                  : null,
                              // disable button for non-bootstrappers/reputables
                              child: Text(l10n.proposalSubmit),
                            ),
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

  /// Dynamically generates form fields based on selected proposal type
  Widget _getProposalExplainer(BuildContext context) {
    final theme = context.textTheme.bodyMedium;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Iconsax.info_circle),
            ),
            Text(_explainerText(), style: theme),
          ],
        ),
      ),
    );
  }

  String _explainerText() {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    switch (selectedAction) {
      case ProposalActionIdentifier.addLocation:
        return l10n.proposalExplainerAddLocation;
      case ProposalActionIdentifier.removeLocation:
        return l10n.proposalExplainerRemoveLocation;
      case ProposalActionIdentifier.updateDemurrage:
        return l10n.proposalExplainerUpdateDemurrage;
      case ProposalActionIdentifier.updateNominalIncome:
        return l10n.proposalExplainerUpdateNominalIncome;
      case ProposalActionIdentifier.setInactivityTimeout:
        return l10n.proposalExplainerSetInactivityTimeout;
      case ProposalActionIdentifier.petition:
        return l10n.proposalExplainerPetition;
      case ProposalActionIdentifier.spendNative:
        return l10n.proposalExplainerSpendNative;
      case ProposalActionIdentifier.issueSwapNativeOption:
        return l10n.proposalExplainerIssueSwapNativeOption(store.encointer.community!.symbol!);
      case ProposalActionIdentifier.spendAsset:
        return l10n.proposalExplainerSpendAsset;
      case ProposalActionIdentifier.issueSwapAssetOption:
        return l10n.proposalExplainerIssueSwapAssetOption(store.encointer.community!.symbol!);
    }
  }

  /// Dynamically generates form fields based on selected proposal type
  Widget _buildDynamicFields(BuildContext context) {
    switch (selectedAction) {
      case ProposalActionIdentifier.addLocation:
        return latitudeLongitudeInput();

      case ProposalActionIdentifier.updateDemurrage:
        return demurrageInput();

      case ProposalActionIdentifier.updateNominalIncome:
        return nominalIncomeInput();

      case ProposalActionIdentifier.setInactivityTimeout:
        return inactivityTimeoutInput();

      case ProposalActionIdentifier.petition:
        return petitionInput(context);

      case ProposalActionIdentifier.spendNative:
        return spendNativeInput(context);

      case ProposalActionIdentifier.issueSwapNativeOption:
        return issueSwapNativeOptionInput();

      case ProposalActionIdentifier.spendAsset:
        return spendAssetInput(context);

      case ProposalActionIdentifier.issueSwapAssetOption:
        return issueSwapAssetOptionInput();

      case ProposalActionIdentifier.removeLocation:
        throw UnimplementedError('remove location is unsupported');
    }
  }

  Widget issueSwapNativeOptionInput() {
    final maxSwapValue = selectedScope.isLocal
        ? maxTreasuryPayoutFraction * Fmt.bigIntToDouble(localTreasuryBalance - pendingLocalSpends, ertDecimals)
        : maxTreasuryPayoutFraction * Fmt.bigIntToDouble(globalTreasuryBalance - pendingGlobalSpends, ertDecimals);
    return Column(children: issueSwapOptionInput('KSM', maxSwapValue));
  }

  Widget issueSwapAssetOptionInput() {
    final maxSwapValue =
        maxTreasuryPayoutFraction * Fmt.bigIntToDouble(assetTreasuryLiquidity(selectedAsset), selectedAsset.decimals);
    return Column(
        children: [selectAssetDropDown(), ...issueSwapOptionInput(selectedAsset.name.toUpperCase(), maxSwapValue)]);
  }

  List<Widget> issueSwapOptionInput(String currency, double? maxValue) {
    final l10n = context.l10n;
    final store = context.read<AppStore>();

    final isKnown = isKnownCommunity(store.encointer.community!.symbol!);

    return [
      TextFormField(
        controller: allowanceController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldAllowance(currency),
          errorText: allowanceError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          // Only numbers & decimal
        ],
        validator: (v) => validatePositiveNumberWithMax(v, maxValue),
        onChanged: (value) {
          setState(() {
            allowanceError = validatePositiveNumberWithMax(value, maxValue);
          });
        },
      ),
      TextFormField(
        controller: rateController
          ..text = isKnown ? rate?.value.toString() ?? '0' : rateController.text, // set constant value if needed
        enabled: !isKnown, // disables editing when condition is true
        decoration: InputDecoration(
          labelText: l10n.proposalFieldRate(
            currency,
            store.encointer.community!.symbol!,
          ),
          errorText: rateError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          // Only numbers & decimal
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        ],
        validator: validatePositiveNumber,
        onChanged: (value) {
          setState(() {
            rateError = validatePositiveNumber(value);
          });
        },
      ),
      const SizedBox(height: 10),
      EncointerAddressInputField(
        store,
        label: l10n.proposalFieldBeneficiary,
        initialValue: beneficiary,
        onChanged: (AccountData acc) {
          setState(() {
            beneficiary = acc;
          });
        },
        hideIdenticon: true,
      ),
      // Text(l10n.proposalFieldBurn, style: const TextStyle(fontWeight: FontWeight.bold)),
      // Text(l10n.proposalFieldValidity, style: const TextStyle(fontWeight: FontWeight.bold)),
    ];
  }

  Widget petitionInput(BuildContext context) {
    final l10n = context.l10n;

    return Utf8LimitedTextField(
      controller: petitionTextController,
      labelText: l10n.proposalFieldPetitionText,
      errorText: petitionError,
      validator: validatePetitionText,
      onChanged: (value) {
        setState(() {
          petitionError = validatePetitionText(value);
        });
      },
      keyboardType: TextInputType.multiline,
      minLines: 5,
      maxLines: 10,
      maxBytes: 256,
    );
  }

  Widget spendNativeInput(BuildContext context) {
    return Column(children: spendInputWidgets('KSM'));
  }

  Widget spendAssetInput(BuildContext context) {
    return Column(children: [
      selectAssetDropDown(),
      ...spendInputWidgets(selectedAsset.symbol),
    ]);
  }

  Widget selectAssetDropDown() {
    final l10n = context.l10n;
    return DropdownButtonFormField<AssetToSpend>(
        initialValue: selectedAsset,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldAssetToSpend,
        ),
        items: AssetToSpend.values.map((asset) {
          return DropdownMenuItem(
            value: asset,
            child: Text(asset.symbol),
          );
        }).toList(),
        onChanged: AssetToSpend.values.length > 1
            ? (AssetToSpend? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedAsset = newValue;
                  });
                }
              }
            : null);
  }

  List<Widget> spendInputWidgets(String currency) {
    final l10n = context.l10n;
    return [
      TextFormField(
        controller: amountController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldAmount(currency),
          errorText: amountError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          // Only numbers & decimal
        ],
        validator: validatePositiveNumber,
        onChanged: (value) {
          setState(() {
            amountError = validatePositiveNumber(value);
          });
        },
      ),
      const SizedBox(height: 10),
      EncointerAddressInputField(
        context.read<AppStore>(),
        label: l10n.proposalFieldBeneficiary,
        initialValue: beneficiary,
        onChanged: (AccountData acc) {
          setState(() {
            beneficiary = acc;
          });
        },
        hideIdenticon: true,
      ),
    ];
  }

  /// Inactivity timeout text form allowing positive integers.
  Widget inactivityTimeoutInput() {
    final l10n = context.l10n;
    return TextFormField(
      controller: inactivityTimeoutController,
      decoration: InputDecoration(
        labelText: l10n.proposalFieldInactivityTimeoutCycles,
        errorText: inactivityTimeoutError,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        // Only numbers & decimal
      ],
      validator: validateInactivityTimeout,
      onChanged: (value) {
        setState(() {
          inactivityTimeoutError = validateInactivityTimeout(value);
        });
      },
    );
  }

  /// Nominal income text form allowing positive integers.
  Widget nominalIncomeInput() {
    final l10n = context.l10n;
    return TextFormField(
      controller: nominalIncomeController,
      decoration: InputDecoration(
        labelText: l10n.proposalFieldNominalIncome,
        errorText: nominalIncomeError,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        // Only numbers & decimal
      ],
      validator: validatePositiveNumber,
      onChanged: (value) {
        setState(() {
          nominalIncomeError = validatePositiveNumber(value);
        });
      },
    );
  }

  /// Demurrage text form allowing numbers between 0 and 100 % per month.
  Widget demurrageInput() {
    final l10n = context.l10n;
    return TextFormField(
      controller: demurrageController,
      decoration: InputDecoration(
        labelText: l10n.proposalFieldDemurragePerMonth,
        errorText: demurrageError,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
        // Only numbers & decimal
      ],
      validator: validateDemurrage,
      onChanged: (value) {
        setState(() {
          demurrageError = validateDemurrage(value);
        });
      },
    );
  }

  Widget latitudeLongitudeInput() {
    final l10n = context.l10n;
    return Column(children: [
      TextFormField(
        controller: latController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldLatitude,
          errorText: latError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$')),
          // Allows negative, decimals, and numbers
        ],
        validator: validateLatitude,
        onChanged: (value) {
          setState(() {
            latError = validateLatitude(value);
          });
        },
      ),
      TextFormField(
        controller: lonController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldLongitude,
          errorText: lonError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*$')),
        ],
        validator: validateLongitude,
        onChanged: (value) {
          setState(() {
            lonError = validateLongitude(value);
          });
        },
      ),
    ]);
  }

  /// Validates the petition text (max length = 256 bytes)
  String? validatePetitionText(String? value) {
    final l10n = context.l10n;

    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterPetitionText;
    } else {
      final bytes = value.codeUnits;
      if (bytes.length > 256) {
        // Onchain we limit the number of bytes to 256
        return l10n.proposalFieldErrorPetitionTextTooLong;
      } else {
        return null;
      }
    }
  }

  /// Validates Latitude (-90 to 90)
  String? validateLatitude(String? value) {
    final l10n = context.l10n;

    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterLatitude;
    } else {
      final latitude = double.tryParse(value);
      if (latitude == null || latitude < -90 || latitude > 90) {
        return l10n.proposalFieldErrorLatitudeRange;
      } else {
        return null;
      }
    }
  }

  /// Validates Longitude (-180 to 180)
  String? validateLongitude(String? value) {
    final l10n = context.l10n;

    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterLongitude;
    } else {
      final longitude = double.tryParse(value);
      if (longitude == null || longitude < -180 || longitude > 180) {
        return l10n.proposalFieldErrorLongitudeRange;
      } else {
        return null;
      }
    }
  }

  /// Validates Demurrage (0 to 100)
  String? validateDemurrage(String? value) {
    final l10n = context.l10n;

    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterDemurrage;
    } else {
      final demurrage = double.tryParse(value);
      if (demurrage == null || demurrage < 0 || demurrage > 100) {
        return l10n.proposalFieldErrorDemurrageRange;
      } else {
        return null;
      }
    }
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
        return l10n.proposalFieldErrorPositiveNumberTooBig;
      } else {
        return null;
      }
    }
  }

  bool isBootstrapperOrReputable(AppStore store, String address) {
    if (store.encointer.community!.bootstrappers!.contains(address)) {
      return true;
    }

    final verifiedReputations = store.encointer.accountStores![address]!.verifiedReputations;

    return selectedScope == ProposalScope.global
        ? verifiedReputations.isNotEmpty
        : verifiedReputations.values.where((cr) => cr.communityIdentifier == store.encointer.chosenCid).isNotEmpty;
  }

  /// Validates Inactivity Timeout (Only positive integers)
  String? validateInactivityTimeout(String? value) {
    final l10n = context.l10n;

    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterInactivityTimeout;
    } else {
      final timeout = int.tryParse(value);
      if (timeout == null || timeout <= 0) {
        return l10n.proposalFieldErrorPositiveIntegerRange;
      } else {
        return null;
      }
    }
  }

  /// Handles form submission
  Future<void> _submitProposal() async {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    if (_formKey.currentState!.validate()) {
      final action = getProposalAction(store);

      await submitDemocracyProposal(
        context,
        store,
        webApi,
        store.account.getKeyringAccount(store.account.currentAccountPubKey!),
        action,
        txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
        onError: (dispatchError) {
          final message = getLocalizedTxErrorMessage(l10n, dispatchError);
          showTxErrorDialog(context, message, false);
        },
        onFinish: (_, __) => Navigator.of(context).pop(),
      );
    }
  }

  ProposalAction getProposalAction(AppStore store) {
    final cid = store.encointer.chosenCid!.toPolkadart();

    switch (selectedAction) {
      case ProposalActionIdentifier.addLocation:
        final location = LocationFactory.fromDouble(
          lat: double.tryParse(latController.text)!,
          lon: double.tryParse(lonController.text)!,
        );
        return AddLocation(cid, location);

      case ProposalActionIdentifier.updateDemurrage:
        final demDouble = monthlyDemurragePercentToDemurrage(
          double.tryParse(demurrageController.text)!,
          BigInt.from(6),
        );
        return UpdateDemurrage(cid, fixedI128FromDouble(demDouble));

      case ProposalActionIdentifier.updateNominalIncome:
        final ni = double.tryParse(nominalIncomeController.text)!;
        return UpdateNominalIncome(cid, fixedU128FromDouble(ni));

      case ProposalActionIdentifier.setInactivityTimeout:
        return SetInactivityTimeout(int.tryParse(inactivityTimeoutController.text)!);

      case ProposalActionIdentifier.petition:
        final maybeCid = selectedScope.isLocal ? cid : null;
        return Petition(maybeCid, petitionTextController.text.codeUnits);

      case ProposalActionIdentifier.spendNative:
        final maybeCid = selectedScope.isLocal ? cid : null;
        final ben = beneficiary!.pubKey;

        final amount = double.tryParse(amountController.text)!;
        return SpendNative(
          maybeCid,
          hex.decode(ben.replaceFirst('0x', '')),
          BigInt.from(amount * pow(10, ertDecimals)),
        );

      case ProposalActionIdentifier.issueSwapNativeOption:
        final maybeCid = selectedScope.isLocal ? cid : null;
        final ben = beneficiary!.pubKey;

        final amount = double.tryParse(allowanceController.text)!;
        final rate = double.tryParse(rateController.text)!;
        final issueOption = SwapNativeOption(
          cid: cid,
          nativeAllowance: BigInt.from(amount * pow(10, ertDecimals)),
          rate: fixedU128FromDouble(rate * pow(10, -ertDecimals)),
          doBurn: true,
        );

        return IssueSwapNativeOption(maybeCid!, hex.decode(ben.replaceFirst('0x', '')), issueOption);

      case ProposalActionIdentifier.spendAsset:
        final maybeCid = selectedScope.isLocal ? cid : null;
        final ben = beneficiary!.pubKey;

        final amount = double.tryParse(amountController.text)!;
        return SpendAsset(maybeCid, hex.decode(ben.replaceFirst('0x', '')),
            BigInt.from(amount * pow(10, selectedAsset.decimals)), selectedAsset.versionedLocatableAsset);

      case ProposalActionIdentifier.issueSwapAssetOption:
        final maybeCid = selectedScope.isLocal ? cid : null;
        final ben = beneficiary!.pubKey;

        final amount = double.tryParse(allowanceController.text)!;
        final rate = double.tryParse(rateController.text)!;
        final issueOption = SwapAssetOption(
          cid: cid,
          assetId: selectedAsset.versionedLocatableAsset,
          assetAllowance: BigInt.from(amount * pow(10, selectedAsset.decimals)),
          rate: fixedU128FromDouble(rate * pow(10, -selectedAsset.decimals)),
          doBurn: true,
        );

        return IssueSwapAssetOption(maybeCid!, hex.decode(ben.replaceFirst('0x', '')), issueOption);

      case ProposalActionIdentifier.removeLocation:
        throw UnimplementedError('removeLocation is unsupported');
    }
  }

  List<Widget> maybeShowTreasuryBalances(BuildContext context) {
    final l10n = context.l10n;
    return [
      if (selectedAction == ProposalActionIdentifier.spendNative && selectedScope.isGlobal)
        Text(
          l10n.treasuryGlobalBalance(Fmt.token(globalTreasuryBalance - pendingGlobalSpends, ertDecimals)),
        ),
      if (selectedAction == ProposalActionIdentifier.spendNative && selectedScope.isLocal ||
          selectedAction == ProposalActionIdentifier.issueSwapNativeOption)
        Text(
          l10n.treasuryLocalBalance(
            Fmt.token(localTreasuryBalance - pendingLocalSpends, ertDecimals),
          ),
        ),
      if (selectedAction == ProposalActionIdentifier.spendAsset && selectedScope.isLocal ||
          selectedAction == ProposalActionIdentifier.issueSwapAssetOption)
        Text(
          l10n.treasuryLocalBalanceOnAHK(
            Fmt.token(
              assetTreasuryLiquidity(selectedAsset),
              selectedAsset.decimals,
            ),
            selectedAsset.symbol,
          ),
        )
    ];
  }

  BigInt assetTreasuryLiquidity(AssetToSpend asset) {
    return localTreasuryBalanceOnAHK -
        swapAssetOptions[selectedAsset]! -
        pendingSwapAssetOptions[selectedAsset]! -
        pendingAssetSpends[selectedAsset]!;
  }
}
