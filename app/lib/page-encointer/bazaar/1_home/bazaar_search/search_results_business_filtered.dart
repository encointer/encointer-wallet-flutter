import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class SearchResultsBusinessFiltered extends StatelessWidget {
  SearchResultsBusinessFiltered(this.results, {super.key});

  final List<BazaarItemData> results;
  final categories = allCategories;
  final deliveryOptions = allDeliveryOptions;
  final productNewnessOptions = allProductNewnessOptions;
  final selectedDeliveryOptions = <bool>[];
  final selectedProductNewnessOptions = <bool>[];

  @override
  Widget build(BuildContext context) {
    final dic = context.l10n;
    const titleStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${dic.filter} ${dic.businessesFound}',
            style: titleStyle,
          ),
        ),
        body: ListView(children: [
          ToggleButtonsWithTitle(context.l10n.categories, categories, null),
        ]),
        floatingActionButton: ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () {}, // TODO state management
              child: Text(context.l10n.reset),
            ),
            ElevatedButton(
              onPressed: () {}, //TODO state management
              child: Text(context.l10n.apply),
            ),
          ],
        ));
  }
}
