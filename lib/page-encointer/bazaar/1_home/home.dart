import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaarItemHorizontal.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demoData.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

import 'BazaarSearch/bazaarSearch.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  final double cardHeight = 200;
  final double cardWidth = 160;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 54),
          child: ListView(
            children: [
              HorizontalBazaarItemList(newInBazaar, dic.bazaar.bazaarNew, cardHeight, cardWidth),
              HorizontalBazaarItemList(businessesInVicinity, dic.bazaar.businessesVicinity, cardHeight, cardWidth),
              HorizontalBazaarItemList(lastVisited, dic.bazaar.lastVisited, cardHeight, cardWidth),
            ],
          ),
        ),
        const BazaarSearch(),
      ],
    );
  }
}
