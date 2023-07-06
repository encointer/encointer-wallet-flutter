import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

class Offerings extends StatelessWidget {
  Offerings({super.key});

  final data = allOfferings;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ToggleButtonsWithTitle(context.l10n.categories, allCategories, null),
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
