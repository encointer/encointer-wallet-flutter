import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demoData.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

import '../shared/toggleButtonsWithTitle.dart';

class Offerings extends StatelessWidget {
  const Offerings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = allOfferings;
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
    ]);
  }
}
