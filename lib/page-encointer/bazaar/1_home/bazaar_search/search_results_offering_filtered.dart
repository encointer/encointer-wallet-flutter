import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class SearchResultsOfferingFiltered extends StatelessWidget {
  SearchResultsOfferingFiltered(this.results, {Key? key}) : super(key: key);

  final List<BazaarItemData> results;
  final categories = allCategories;
  final deliveryOptions = allDeliveryOptions;
  final productNewnessOptions = allProductNewnessOptions;
  final selectedDeliveryOptions = <bool>[];
  final selectedProductNewnessOptions = <bool>[];
  final _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontWeight: FontWeight.bold, height: 2.5);
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter ${dic.bazaar.found} ${dic.bazaar.offerings}'),
      ),
      body: ListView(children: [
        ToggleButtonsWithTitle(dic.bazaar.categories, categories, null),
        Text(
          dic.bazaar.price,
          style: titleStyle,
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 100,
          divisions: 5,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            // TODO state management
          },
        ),
        Text(
          dic.bazaar.delivery,
          style: titleStyle,
        ),
        ToggleButtons(
          isSelected: selectedDeliveryOptions,
          children: deliveryOptions.map((option) => Text(option)).toList(),
        ),
        Text(
          dic.bazaar.productNewness,
          style: titleStyle,
        ),
        ToggleButtons(
          isSelected: selectedProductNewnessOptions,
          children: productNewnessOptions.map((option) => Text(option)).toList(),
        ),
      ]),
      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton(
              onPressed: () {}, // TODO state management
              child: Text(dic.bazaar.reset)),
          ElevatedButton(
              onPressed: () {}, //TODO state management
              child: Text(dic.bazaar.apply)),
        ],
      ),
    );
  }
}
