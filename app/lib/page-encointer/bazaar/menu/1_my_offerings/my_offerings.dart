import 'package:encointer_wallet/page-encointer/bazaar/menu/1_my_offerings/offering_form.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

class MyOfferings extends StatelessWidget {
  MyOfferings({super.key});

  final data = myOfferings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.offeringsMy),
      ),
      body: Column(children: [
        ToggleButtonsWithTitle(context.l10n.categories, allCategories, null),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => BazaarItemVertical(
              data: data,
              index: index,
              cardHeight: 125,
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const OfferingForm(),
              ),
            );
          }),
    );
  }
}
