import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

class OfferingDetail extends StatelessWidget {
  final BazaarOfferingData offering;
  final productNewness = allProductNewnessOptions; // TODO state management
  final deliveryOptions = allDeliveryOptions; // TODO state management

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("${offering.title}"),
            SizedBox(
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
                child: Container(padding: EdgeInsets.all(4), child: offering.image),
              ),
              Text("${offering.description}"),
              SizedBox(
                height: 8,
              ),
              ToggleButtonsWithTitle(I18n.of(context)!.translationsForLocale().bazaar.state, productNewness, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle(
                  I18n.of(context)!.translationsForLocale().bazaar.deliveryOptions, deliveryOptions, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
            ],
          ),
        ],
      ),
    );
  }

  OfferingDetail(this.offering);
}
