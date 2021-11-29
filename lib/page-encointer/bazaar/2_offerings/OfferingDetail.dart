import 'package:encointer_wallet/page-encointer/bazaar/shared/ToggleButtonsWithTitle.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/DemoData.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/BazaarItemData.dart';
import 'package:flutter/material.dart';

class OfferingDetail extends StatelessWidget {
  final BazaarOfferingData offering;
  var productNewness = allProductNewnessOptions; // TODO state management
  var deliveryOptions = allDeliveryOptions; // TODO state management

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
              ToggleButtonsWithTitle("State", productNewness, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
              ToggleButtonsWithTitle("Delivery Options", deliveryOptions, null),
              // TODO state mananagement, TODO has to be an business.id not just the title
            ],
          ),
        ],
      ),
    );
  }

  OfferingDetail(this.offering);
}
