import 'dart:math';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/common/components/address_input_field.dart';
import 'package:encointer_wallet/common/components/submit_button.dart';
import 'package:encointer_wallet/page-encointer/democracy/proposal_page/helpers.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/service/tx/lib/tx.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:ew_primitives/ew_primitives.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:ew_polkadart/ew_polkadart.dart'
    show
        AddLocation,
        IssueSwapNativeOption,
        Petition,
        ProposalAction,
        SetInactivityTimeout,
        SpendNative,
        UpdateDemurrage,
        UpdateNominalIncome,
        SwapNativeOption;

class ProposePage extends StatefulWidget {
  const ProposePage({super.key});

  static const String route = '/propose';

  @override
  State<ProposePage> createState() => _ProposePageState();
}

class _ProposePageState extends State<ProposePage> {
  final _formKey = GlobalKey<FormState>();

  // Default selected values
  ProposalActionIdentifier selectedAction = ProposalActionIdentifier.petition;
  late ProposalScope selectedScope;
  List<ProposalScope> allowedScopes = [];

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

  @override
  void initState() {
    super.initState();
    _updateAllowedScopes();

    beneficiary = context.read<AppStore>().account.currentAccount;
  }

  /// Updates the allowed scope options and resets the selectedScope
  void _updateAllowedScopes() {
    setState(() {
      allowedScopes = selectedAction.allowedPolicies();
      selectedScope = allowedScopes.first; // Default to the first allowed scope
    });
  }

  @override
  void dispose() {
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
            child: Column(
              children: [
                // Proposal Action Selector
                DropdownButtonFormField<ProposalActionIdentifier>(
                  value: selectedAction,
                  onChanged: (ProposalActionIdentifier? newValue) {
                    setState(() {
                      selectedAction = newValue!;
                      _updateAllowedScopes();
                    });
                  },
                  items: supportedProposalIds().map((ProposalActionIdentifier action) {
                    return DropdownMenuItem<ProposalActionIdentifier>(
                      value: action,
                      child: Text(action.localizedStr(l10n)),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: l10n.proposalType),
                ),

                const SizedBox(height: 10),

                // Scope Selector
                DropdownButtonFormField<ProposalScope>(
                  value: selectedScope,
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
                      child: Text(scope.localizedStr(l10n)),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: l10n.proposalScope),
                ),

                const SizedBox(height: 10),

                // Dynamic Fields Based on Selected Proposal Action
                _buildDynamicFields(context),

                // Submit Button
                const Spacer(),
                if (!isBootstrapperOrReputable(store, store.account.currentAddress))
                  Text(l10n.proposalOnlyBootstrappersOrReputablesCanSubmit, textAlign: TextAlign.center),
                SubmitButton(
                  onPressed: isBootstrapperOrReputable(store, store.account.currentAddress)
                      ? (context) async {
                          _formKey.currentState!.validate();
                          await _submitProposal();
                          Navigator.of(context).pop();
                        }
                      : null, // disable button for non-bootstrappers/reputables
                  child: Text(l10n.proposalSubmit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    }
  }

  Widget issueSwapNativeOptionInput() {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    return Column(children: [
      TextFormField(
        controller: allowanceController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldAllowance,
          errorText: allowanceError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          // Only numbers & decimal
        ],
        validator: validatePositiveNumber,
        onChanged: (value) {
          setState(() {
            allowanceError = validatePositiveNumber(value);
          });
        },
      ),
      TextFormField(
        controller: rateController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldRate,
          errorText: rateError,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
          // Only numbers & decimal
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
    ]);
  }

  Widget petitionInput(BuildContext context) {
    final l10n = context.l10n;

    return TextFormField(
      controller: petitionTextController,
      decoration: InputDecoration(
        labelText: l10n.proposalFieldPetitionText,
        errorText: petitionError,
      ),
      validator: validatePetitionText,
      onChanged: (value) {
        setState(() {
          petitionError = validatePetitionText(value);
        });
      },
      keyboardType: TextInputType.multiline,
      minLines: 5,
      maxLines: 10,
    );
  }

  Widget spendNativeInput(BuildContext context) {
    final store = context.read<AppStore>();
    final l10n = context.l10n;
    return Column(children: [
      TextFormField(
        controller: amountController,
        decoration: InputDecoration(
          labelText: l10n.proposalFieldAmount,
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
    ]);
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
    final l10n = context.l10n;
    if (value == null || value.isEmpty) {
      return l10n.proposalFieldErrorEnterPositiveNumber;
    } else {
      final number = double.tryParse(value);
      if (number == null || number <= 0) {
        return l10n.proposalFieldErrorPositiveNumberRange;
      } else {
        return null;
      }
    }
  }

  bool isBootstrapperOrReputable(AppStore store, String address) {
    return store.encointer.community!.bootstrappers!.contains(address) ||
        store.encointer.accountStores![address]!.verifiedReputations.isNotEmpty;
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

    if (_formKey.currentState!.validate()) {
      final action = getProposalAction(store);

      await submitDemocracyProposal(
        context,
        store,
        webApi,
        store.account.getKeyringAccount(store.account.currentAccountPubKey!),
        action,
        txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
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
          BigInt.from(amount * pow(10, 12)),
        );

      case ProposalActionIdentifier.issueSwapNativeOption:
        final maybeCid = selectedScope.isLocal ? cid : null;
        final ben = beneficiary!.pubKey;

        final amount = double.tryParse(allowanceController.text)!;
        final rate = double.tryParse(rateController.text)!;
        final issueOption = SwapNativeOption(
          cid: cid,
          nativeAllowance: BigInt.from(amount * pow(10, 12)),
          rate: fixedU128FromDouble(rate),
          doBurn: true,
        );

        return IssueSwapNativeOption(maybeCid!, hex.decode(ben.replaceFirst('0x', '')), issueOption);
    }
  }
}
