import 'package:ew_translations/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';

class Offerings extends StatelessWidget {
  Offerings({super.key});

  final data = allOfferings;

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
    ]);
  }
}
