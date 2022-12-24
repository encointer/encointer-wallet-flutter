import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});

  final data = favorites;

  @override
  Widget build(BuildContext context) {
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
