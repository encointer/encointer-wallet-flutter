import 'package:encointer_wallet/page-encointer/bazaar/menu/1_my_offerings/OfferingForm.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/BazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/ToggleButtonsWithTitle.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/DemoData.dart';
import 'package:flutter/material.dart';

class MyOfferings extends StatelessWidget {
  final data = myOfferings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Offerings"),
      ),
      body: Column(children: [
        ToggleButtonsWithTitle("Categories", allCategories, null), // TODO state management
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
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OfferingForm(),
              ),
            );
          }),
    );
  }
}
