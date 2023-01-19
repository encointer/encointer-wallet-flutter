import 'package:ew_translations/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/businesses_on_map.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';

class Businesses extends StatelessWidget {
  Businesses({super.key});

  final data = allBusinesses;

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Column(children: [
      ToggleButtonsWithTitle(dic.bazaar.categories, allCategories, null),
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
              MaterialPageRoute<void>(
                builder: (context) => BusinessesOnMap(),
              ));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.map),
            Text(dic.bazaar.map),
          ],
        ),
      )
    ]);
  }
}
