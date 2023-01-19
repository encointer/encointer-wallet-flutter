import 'package:flutter/material.dart';
import 'package:translation/translation.dart';

import 'package:encointer_wallet/page-encointer/bazaar/1_home/bazaar_search/search_results_offering_filtered.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';

class SearchResultsOffering extends StatelessWidget {
  const SearchResultsOffering(this.results, {super.key});

  final List<BazaarItemData> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${results.length} ${context.dic.bazaar.offeringsFound}'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 6,
            child: ListTile(
              leading: const Icon(Icons.filter_alt),
              title: Text(context.dic.bazaar.filter),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => SearchResultsOfferingFiltered(results),
                  ),
                );
              }, // TODO state management
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) => BazaarItemVertical(
                data: results,
                index: index,
                cardHeight: 125,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
