import 'package:encointer_wallet/page-encointer/democracy/proposal_page/helpers.dart';
import 'package:flutter/material.dart';

// import 'package:encointer_wallet/store/app.dart';
// import 'package:provider/provider.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ProposePage extends StatefulWidget {
  const ProposePage({super.key});

  static const String route = '/propose';

  @override
  State<ProposePage> createState() => _ProposePageState();
}

class _ProposePageState extends State<ProposePage> {
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

  @override
  void initState() {
    super.initState();
    _updateAllowedScopes();
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
                items: ProposalActionIdentifier.values.map((ProposalActionIdentifier action) {
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
              _buildDynamicFields(),

              // Submit Button
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProposal,
                child: const Text('Submit Proposal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Dynamically generates form fields based on selected proposal type
  Widget _buildDynamicFields() {
    switch (selectedAction) {
      case ProposalActionIdentifier.addLocation:
        return Column(children: [
          TextFormField(controller: latController, decoration: const InputDecoration(labelText: 'Latitude')),
          TextFormField(controller: lonController, decoration: const InputDecoration(labelText: 'Longitude')),
        ]);

      case ProposalActionIdentifier.updateDemurrage:
        return TextFormField(
            controller: demurrageController, decoration: const InputDecoration(labelText: 'Demurrage (%)'));

      case ProposalActionIdentifier.updateNominalIncome:
        return TextFormField(
            controller: nominalIncomeController, decoration: const InputDecoration(labelText: 'Nominal Income'));

      case ProposalActionIdentifier.setInactivityTimeout:
        return TextFormField(
            controller: inactivityTimeoutController,
            decoration: const InputDecoration(labelText: 'Inactivity Timeout (cycles)'));

      case ProposalActionIdentifier.petition:
        return TextFormField(
            controller: petitionTextController, decoration: const InputDecoration(labelText: 'Petition Text'));

      case ProposalActionIdentifier.spendNative:
        return Column(children: [
          TextFormField(controller: amountController, decoration: const InputDecoration(labelText: 'Amount')),
          // Implement dropdown for beneficiary selection (contacts and own accounts)
        ]);

      case ProposalActionIdentifier.issueSwapNativeOption:
        return Column(children: [
          TextFormField(
              controller: allowanceController, decoration: const InputDecoration(labelText: 'Allowance (KSM)')),
          TextFormField(controller: rateController, decoration: const InputDecoration(labelText: 'Rate')),
          const Text('Burn: true (hardcoded)', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Validity: None (hardcoded)', style: TextStyle(fontWeight: FontWeight.bold)),
        ]);
    }
  }

  /// Handles form submission
  void _submitProposal() {
    print('Submitted Proposal: $selectedAction');
    print('Scope: $selectedScope');
    // Implement logic to send data where needed
  }
}
