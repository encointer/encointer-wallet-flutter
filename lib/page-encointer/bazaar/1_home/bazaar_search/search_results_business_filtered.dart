import 'package:ew_translations/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';

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
    const titleStyle = TextStyle(fontWeight: FontWeight.bold);
    final dic = context.dic;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${dic.bazaar.filter} ${dic.bazaar.businessesFound}',
            style: titleStyle,
          ),
        ),
        body: ListView(children: [
          ToggleButtonsWithTitle(dic.bazaar.categories, categories, null),
        ]),
        floatingActionButton: ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () {}, // TODO state management
              child: Text(dic.bazaar.reset),
            ),
            ElevatedButton(
              onPressed: () {}, //TODO state management
              child: Text(dic.bazaar.apply),
            ),
          ],
        ));
  }
}
