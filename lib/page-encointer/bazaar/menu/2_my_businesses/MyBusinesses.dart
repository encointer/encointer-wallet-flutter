import 'package:flutter/material.dart';
import '../../shared/BazaarItemVertical.dart';
import '../../shared/data_model/demo_data/DemoData.dart';

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
                  )),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessFormScaffold()));
          }),
    );
  }
}
