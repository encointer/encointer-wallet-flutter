import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

class OfferingForm extends StatefulWidget {
  const OfferingForm({super.key});

  @override
  State<OfferingForm> createState() => _OfferingFormState();
}

class _OfferingFormState extends State<OfferingForm> {
  final categories = allCategories; // TODO state management
  final businesses = myBusinesses; // TODO state management
  final productNewness = allProductNewnessOptions; // TODO state management
  final deliveryOptions = allDeliveryOptions; // TODO state management

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.offeringAdd),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 80),
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    child: ListTile(
                      leading: const Icon(Icons.add_a_photo),
                      title: Text(l10n.photoAdd),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: l10n.useDescriptiveName,
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l10n.description,
                ),
              ),
              ToggleButtonsWithTitle(l10n.categories, categories, null),
              // TODO state mananagement
              ToggleButtonsWithTitle(
                  l10n.businessesOffered, businesses.map((business) => business.title).toList(), null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle(l10n.state, productNewness, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle(l10n.deliveryOptions, deliveryOptions, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
            ],
          ),
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          ElevatedButton(
            child: Row(children: [const Icon(Icons.delete), Text(l10n.delete)]),
            onPressed: () {
              // TODO modify state
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: Row(children: [const Icon(Icons.check), Text(l10n.save)]),
            onPressed: () {
              // TODO modify state
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
