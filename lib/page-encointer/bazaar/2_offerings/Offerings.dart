import 'package:encointer_wallet/page-encointer/bazaar/shared/BazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/DemoData.dart';
import 'package:flutter/material.dart';

import '../shared/ToggleButtonsWithTitle.dart';

class Offerings extends StatelessWidget {
  final data = allOfferings;

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
    ]);
  }
}
