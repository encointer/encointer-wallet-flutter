import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/material.dart';

class SearchResultsOfferingFiltered extends StatelessWidget {
  final results;
  final categories = allCategories;
  final deliveryOptions = allDeliveryOptions;
  final productNewnessOptions = allProductNewnessOptions;
  final selectedDeliveryOptions = <bool>[];
  final selectedProductNewnessOptions = <bool>[];
  final _currentRangeValues = const RangeValues(40, 80);

  SearchResultsOfferingFiltered(this.results, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle = const TextStyle(fontWeight: FontWeight.bold, height: 2.5);
    final Translations dic = I18n.of(context)!.translationsForLocale();
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
            children: deliveryOptions.map((option) => Text(option)).toList(), isSelected: selectedDeliveryOptions),
        Text(
          dic.bazaar.productNewness,
          style: titleStyle,
        ),
        ToggleButtons(
            children: productNewnessOptions.map((option) => Text(option)).toList(),
            isSelected: selectedProductNewnessOptions),
      ]),
      floatingActionButton: ButtonBar(
        children: [
          ElevatedButton(
              onPressed: () => null, // TODO state management
              child: Text(dic.bazaar.reset)),
          ElevatedButton(
              onPressed: () => null, //TODO state management
              child: Text(dic.bazaar.apply)),
        ],
      ),
    );
  }
}
