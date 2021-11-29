import 'package:flutter/material.dart';

import '../0_main/BazaarMainState.dart';
import '../shared/BazaarItemVertical.dart';
import '../shared/data_model/demo_data/DemoData.dart';

class Favorites extends StatelessWidget {
  final BazaarMainState bazaarMainState;
  final data = favorites;

  Favorites(this.bazaarMainState);

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
