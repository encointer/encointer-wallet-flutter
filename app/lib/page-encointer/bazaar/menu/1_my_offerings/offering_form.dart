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
    final dic = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.offeringAdd),
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
                      title: Text(dic.photoAdd),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: dic.useDescriptiveName,
                ),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: dic.description,
                ),
              ),
              ToggleButtonsWithTitle(dic.categories, categories, null),
              // TODO state mananagement
              ToggleButtonsWithTitle(
                  dic.businessesOffered, businesses.map((business) => business.title).toList(), null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle(dic.state, productNewness, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle(dic.deliveryOptions, deliveryOptions, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
            ],
          ),
        ),
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          ElevatedButton(
            child: Row(children: [const Icon(Icons.delete), Text(dic.delete)]),
            onPressed: () {
              // TODO modify state
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: Row(children: [const Icon(Icons.check), Text(dic.save)]),
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
