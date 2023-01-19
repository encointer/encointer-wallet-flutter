import 'package:flutter/material.dart';
import 'package:translation/translation.dart';

import 'package:encointer_wallet/page-encointer/bazaar/1_home/bazaar_search/bazaar_search.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_horizontal.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';

class Home extends StatelessWidget {
  const Home({super.key, this.cardHeight = 200, this.cardWidth = 160});

  final double cardHeight;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Padding(
        padding: const EdgeInsets.only(top: 54),
        child: ListView(children: [
          HorizontalBazaarItemList(newInBazaar, context.dic.bazaar.bazaarNew, cardHeight, cardWidth),
          HorizontalBazaarItemList(businessesInVicinity, context.dic.bazaar.businessesVicinity, cardHeight, cardWidth),
          HorizontalBazaarItemList(lastVisited, context.dic.bazaar.lastVisited, cardHeight, cardWidth),
        ]),
      ),
      const BazaarSearch(),
    ]);
  }
}
