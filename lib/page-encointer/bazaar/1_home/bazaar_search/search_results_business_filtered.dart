import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class SearchResultsBusinessFiltered extends StatelessWidget {
  final List<BazaarItemData> results;
  final categories = allCategories;
  final deliveryOptions = allDeliveryOptions;
  final productNewnessOptions = allProductNewnessOptions;
  final selectedDeliveryOptions = <bool>[];
  final selectedProductNewnessOptions = <bool>[];

  SearchResultsBusinessFiltered(this.results, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Translations dic = I18n.of(context)!.translationsForLocale();
    var titleStyle = const TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${dic.bazaar.filter} ${dic.bazaar.businessesFound}',
            style: titleStyle,
          ),
        ),
        body: ListView(children: [
          ToggleButtonsWithTitle(I18n.of(context)!.translationsForLocale().bazaar.categories, categories, null),
        ]),
        floatingActionButton: ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () => null, // TODO state management
              child: Text(I18n.of(context)!.translationsForLocale().bazaar.reset),
            ),
            ElevatedButton(
              onPressed: () => null, //TODO state management
              child: Text(I18n.of(context)!.translationsForLocale().bazaar.apply),
            ),
          ],
        ));
  }
}
