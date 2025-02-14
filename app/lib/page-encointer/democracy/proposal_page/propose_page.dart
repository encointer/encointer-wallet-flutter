import 'dart:math';

import 'package:convert/convert.dart';
import 'package:encointer_wallet/common/components/address_input_field.dart';
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
    show AddLocation, Petition, ProposalAction, SetInactivityTimeout, SpendNative, UpdateDemurrage, UpdateNominalIncome;

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
    // final store = context.read<AppStore>();
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
                      child: Text(action.name), // Converts enum to string
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Proposal Action Identifier'),
                ),

                const SizedBox(height: 10),

                // Scope Selector (Dropdown using Enum)
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
                      child: Text(scope.name),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Scope'),
                ),

                const SizedBox(height: 10),

                // Dynamic Fields Based on Selected Proposal Action
                _buildDynamicFields(context),

                // Submit Button
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                    _submitProposal();
                  },
                  child: const Text('Submit Proposal'),
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
        return TextFormField(
            controller: petitionTextController, decoration: const InputDecoration(labelText: 'Petition Text'));

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
      EncointerAddressInputField(
        store,
        label: l10n.address,
        initialValue: beneficiary,
        onChanged: (AccountData acc) {
          setState(() {
            beneficiary = acc;
          });
        },
        hideIdenticon: true,
      ),
      TextFormField(
        controller: allowanceController,
        decoration: InputDecoration(
          labelText: 'Allowance (KSM)',
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
          labelText: 'Rate',
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
      const Text('Burn: true (hardcoded)', style: TextStyle(fontWeight: FontWeight.bold)),
      const Text('Validity: None (hardcoded)', style: TextStyle(fontWeight: FontWeight.bold)),
    ]);
  }

  Widget spendNativeInput(BuildContext context) {
    final store = context.read<AppStore>();
    final l10n = context.l10n;

    return Column(children: [
      EncointerAddressInputField(
        store,
        label: l10n.address,
        initialValue: beneficiary,
        onChanged: (AccountData acc) {
          setState(() {
            beneficiary = acc;
          });
        },
        hideIdenticon: true,
      ),
      TextFormField(
        controller: amountController,
        decoration: InputDecoration(
          labelText: 'Amount',
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
    ]);
  }

  /// Inactivity timeout text form allowing positive integers.
  Widget inactivityTimeoutInput() {
    return TextFormField(
      controller: inactivityTimeoutController,
      decoration: InputDecoration(
        labelText: 'Inactivity Timeout (cycles)',
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
    return TextFormField(
      controller: nominalIncomeController,
      decoration: InputDecoration(
        labelText: 'Nominal Income',
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
    return TextFormField(
      controller: demurrageController,
      decoration: InputDecoration(
        labelText: 'Demurrage (%/month)',
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
    return Column(children: [
      TextFormField(
        controller: latController,
        decoration: InputDecoration(
          labelText: 'Latitude',
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
          labelText: 'Longitude',
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

  /// Validates Latitude (-90 to 90)
  String? validateLatitude(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter latitude';
    } else {
      final latitude = double.tryParse(value);
      if (latitude == null || latitude < -90 || latitude > 90) {
        return 'Latitude must be between -90 and 90';
      } else {
        return null;
      }
    }
  }

  /// Validates Longitude (-180 to 180)
  String? validateLongitude(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter longitude';
    } else {
      final longitude = double.tryParse(value);
      if (longitude == null || longitude < -180 || longitude > 180) {
        return 'Longitude must be between -180 and 180';
      } else {
        return null;
      }
    }
  }

  /// Validates Demurrage (0 to 100)
  String? validateDemurrage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter demurrage';
    } else {
      final demurrage = double.tryParse(value);
      if (demurrage == null || demurrage < 0 || demurrage > 100) {
        return 'Demurrage must be between 0 and 100';
      } else {
        return null;
      }
    }
  }

  /// Ensures that the number is positive (doubles)
  String? validatePositiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter positive number';
    } else {
      final number = double.tryParse(value);
      if (number == null || number <= 0) {
        return 'Must be a positive number';
      } else {
        return null;
      }
    }
  }

  /// Validates Inactivity Timeout (Only positive integers)
  String? validateInactivityTimeout(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter inactivity timeout';
    } else {
      final timeout = int.tryParse(value);
      if (timeout == null || timeout <= 0) {
        return 'Must be a positive integer';
      } else {
        return null;
      }
    }
  }

  /// Handles form submission
  Future<void> _submitProposal() async {
    final store = context.read<AppStore>();

    print('Submitted Proposal: $selectedAction');
    print('Scope: $selectedScope');

    if (_formKey.currentState!.validate()) {
      final action = getProposalAction(store);

      await submitDemocracyProposal(
        context,
        store,
        webApi,
        store.account.getKeyringAccount(store.account.currentAccountPubKey!),
        action!,
        txPaymentAsset: store.encointer.getTxPaymentAsset(store.encointer.chosenCid),
      );
    }
  }

  ProposalAction? getProposalAction(AppStore store) {
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
      // @todo: Generate issueSwapNativeType
    }
    return null;
  }
}
