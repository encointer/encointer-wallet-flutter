import 'package:flutter/material.dart';
import '../shared/BazaarItemVertical.dart';
import '../shared/data_model/demo_data/DemoData.dart';

class Favorites extends StatelessWidget {
  final data = favorites;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => BazaarItemVertical(
              data: data,
              index: index,
              cardHeight: 125,
            ));
  }
}
