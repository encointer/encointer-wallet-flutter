import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/BusinessesOnMap.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/BazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/ToggleButtonsWithTitle.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/DemoData.dart';
import 'package:flutter/material.dart';

class Businesses extends StatelessWidget {
  final data = allBusinesses;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ToggleButtonsWithTitle("Categories", allCategories, null), // TODO state management
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
      ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessesOnMap(),
              ));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Icon(Icons.map),
            new Text('Map'),
          ],
        ),
      )
    ]);
  }
}
