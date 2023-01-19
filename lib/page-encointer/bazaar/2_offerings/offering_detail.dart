import 'package:ew_translation/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';

class OfferingDetail extends StatelessWidget {
  OfferingDetail(this.offering, {super.key});

  final BazaarOfferingData offering;
  final productNewness = allProductNewnessOptions; // TODO state management
  final deliveryOptions = allDeliveryOptions; // TODO state management

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(offering.title),
            const SizedBox(
              width: 6,
            ),
            offering.icon
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Center(
                child: Container(padding: const EdgeInsets.all(4), child: offering.image),
              ),
              Text(offering.description),
              const SizedBox(
                height: 8,
              ),
              ToggleButtonsWithTitle(dic.bazaar.state, productNewness, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle(dic.bazaar.deliveryOptions, deliveryOptions, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
            ],
          ),
        ],
      ),
    );
  }
}
