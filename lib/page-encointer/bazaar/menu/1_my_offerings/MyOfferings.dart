import 'package:flutter/material.dart';
import '../../menu/1_my_offerings/OfferingForm.dart';
import '../../shared/BazaarItemVertical.dart';
import '../../shared/ToggleButtonsWithTitle.dart';
import '../../shared/data_model/demo_data/DemoData.dart';

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
                  )),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => OfferingForm()));
          }),
    );
  }
}
