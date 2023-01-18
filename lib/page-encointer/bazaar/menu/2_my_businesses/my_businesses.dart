import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/business_form.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:translation_package/translation_package.dart';

class MyBusinesses extends StatelessWidget {
  MyBusinesses({super.key});

  final data = myBusinesses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context)!.translationsForLocale().bazaar.businessesMy),
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
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => BusinessFormScaffold(),
                ));
          }),
    );
  }
}
