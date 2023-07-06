import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_horizontal.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class Home extends StatelessWidget {
  const Home({super.key, this.cardHeight = 200, this.cardWidth = 160});

  final double cardHeight;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Stack(fit: StackFit.expand, children: [
      Padding(
        padding: const EdgeInsets.only(top: 54),
        child: ListView(children: [
          HorizontalBazaarItemList(newInBazaar, l10n.bazaarNew, cardHeight, cardWidth),
          HorizontalBazaarItemList(businessesInVicinity, l10n.businessesVicinity, cardHeight, cardWidth),
          HorizontalBazaarItemList(lastVisited, l10n.lastVisited, cardHeight, cardWidth),
        ]),
      ),
    ]);
  }
}
