import 'package:encointer_wallet/page-encointer/bazaar/shared/BazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/DemoData.dart';
import 'package:flutter/material.dart';

import 'BusinessForm.dart';

class MyBusinesses extends StatelessWidget {
  final data = myBusinesses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Businesses"),
      ),
      body: Column(children: [
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
                  builder: (context) => BusinessFormScaffold(),
                ));
          }),
    );
  }
}
