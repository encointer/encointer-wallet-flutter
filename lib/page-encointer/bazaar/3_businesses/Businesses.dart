import 'package:flutter/material.dart';
import '../menu/2_my_businesses/BusinessesOnMap.dart';
import '../shared/BazaarItemVertical.dart';
import '../shared/ToggleButtonsWithTitle.dart';
import '../shared/data_model/demo_data/DemoData.dart';

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
                )),
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessesOnMap()));
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Icon(Icons.map),
              new Text('Map'),
            ],
          ))
    ]);
  }
}
