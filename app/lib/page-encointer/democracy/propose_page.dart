import 'package:encointer_wallet/service/launch/app_launch.dart';
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
  String proposalType = 'petition';
  String scope = 'local';
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
        child: Column(
          children: [
            // Proposal Action Selector
            DropdownButtonFormField<String>(
              value: proposalType,
              onChanged: (value) {
                setState(() {
                  proposalType = value!;
                });
              },
              items: [
                'addlocation',
                'updateDemurrage',
                'updateNominalIncome',
                'setInactivityTimeout',
                'petition',
                'spendNative',
                'issueSwapNativeOption'
              ].map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
              decoration: InputDecoration(labelText: 'Proposal Action Identifier'),
            ),

            // Scope Selector
            DropdownButtonFormField<String>(
              value: scope,
              onChanged: (value) {
                setState(() {
                  scope = value!;
                });
              },
              items: ['global', 'local'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              decoration: InputDecoration(labelText: 'Scope'),
            ),

            // Dynamic Fields
            if (proposalType == 'addlocation') ...[
              TextFormField(controller: latController, decoration: InputDecoration(labelText: 'Latitude')),
              TextFormField(controller: lonController, decoration: InputDecoration(labelText: 'Longitude')),
            ],
            if (proposalType == 'updateDemurrage')
              TextFormField(controller: demurrageController, decoration: InputDecoration(labelText: 'Demurrage (%)')),
            if (proposalType == 'updateNominalIncome')
              TextFormField(controller: nominalIncomeController, decoration: InputDecoration(labelText: 'Nominal Income')),
            if (proposalType == 'setInactivityTimeout')
              TextFormField(controller: inactivityTimeoutController, decoration: InputDecoration(labelText: 'Inactivity Timeout (cycles)')),
            if (proposalType == 'petition')
              TextFormField(controller: petitionTextController, decoration: InputDecoration(labelText: 'Petition Text')),
            if (proposalType == 'spendNative') ...[
              TextFormField(controller: amountController, decoration: InputDecoration(labelText: 'Amount')),
              // Implement dropdown for beneficiary (linked to contacts and accounts)
            ],
            if (proposalType == 'issueSwapNativeOption') ...[
              TextFormField(controller: allowanceController, decoration: InputDecoration(labelText: 'Allowance (KSM)')),
              TextFormField(controller: rateController, decoration: InputDecoration(labelText: 'Rate')),
              Text('Burn: true (hardcoded)', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Validity: None (hardcoded)', style: TextStyle(fontWeight: FontWeight.bold)),
            ],

            // Submit Button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
                print('Submitted Proposal: $proposalType');
              },
              child: Text('Submit Proposal'),
            ),
          ],
        ),
      ),
    );
  }
}
