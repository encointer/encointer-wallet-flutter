import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = favorites;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => BazaarItemVertical(
        data: data,
        index: index,
        cardHeight: 125,
      ),
    );
  }
}
