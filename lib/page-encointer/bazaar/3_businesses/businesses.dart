import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/businessesOnMap.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demoData.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggleButtonsWithTitle.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

class Businesses extends StatelessWidget {
  const Businesses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = allBusinesses;
    return Column(children: [
      ToggleButtonsWithTitle(I18n.of(context)!.translationsForLocale().bazaar.categories, allCategories, null),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessesOnMap()));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.map),
            Text(I18n.of(context)!.translationsForLocale().bazaar.map),
          ],
        ),
      )
    ]);
  }
}
