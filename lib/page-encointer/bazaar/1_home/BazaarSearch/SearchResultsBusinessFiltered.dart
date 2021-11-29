import 'package:encointer_wallet/page-encointer/bazaar/shared/ToggleButtonsWithTitle.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/DemoData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchResultsBusinessFiltered extends StatelessWidget {
  final results;
  final categories = allCategories;
  final deliveryOptions = allDeliveryOptions;
  final productNewnessOptions = allProductNewnessOptions;
  var selectedDeliveryOptions;
  var selectedProductNewnessOptions;
  var _currentRangeValues = const RangeValues(40, 80);

  SearchResultsBusinessFiltered(this.results, {Key key}) : super(key: key) {
    selectedDeliveryOptions = List.filled(deliveryOptions.length, false);
    selectedProductNewnessOptions = List.filled(deliveryOptions.length, false);
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontWeight: FontWeight.bold);

    return Scaffold(
        appBar: AppBar(
          title: Text("Filter found businesses"),
        ),
        body: ListView(children: [
          ToggleButtonsWithTitle("Categories", categories, null), // TODO state management
        ]),
        floatingActionButton: ButtonBar(
          children: [
            ElevatedButton(
              onPressed: () => null, // TODO state management
              child: Text("Reset"),
            ),
            ElevatedButton(
              onPressed: () => null, //TODO state management
              child: Text("Apply"),
            ),
          ],
        ));
  }
}
