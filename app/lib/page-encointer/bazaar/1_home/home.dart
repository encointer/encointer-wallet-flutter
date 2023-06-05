import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_horizontal.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class Home extends StatelessWidget {
  const Home({super.key, this.cardHeight = 200, this.cardWidth = 160});

  final double cardHeight;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Stack(fit: StackFit.expand, children: [
      Padding(
        padding: const EdgeInsets.only(top: 54),
        child: ListView(children: [
          HorizontalBazaarItemList(newInBazaar, dic.bazaar.bazaarNew, cardHeight, cardWidth),
          HorizontalBazaarItemList(businessesInVicinity, dic.bazaar.businessesVicinity, cardHeight, cardWidth),
          HorizontalBazaarItemList(lastVisited, dic.bazaar.lastVisited, cardHeight, cardWidth),
        ]),
      ),
    ]);
  }
}
