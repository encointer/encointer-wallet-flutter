import 'package:flutter/material.dart';

import 'package:encointer_wallet/page-encointer/bazaar/1_home/bazaar_search/search_results_business_filtered.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaar_item_vertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaar_item_data.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class SearchResultsBusiness extends StatelessWidget {
  const SearchResultsBusiness(this.results, {super.key});

  final List<BazaarItemData> results;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text('${results.length} ${I18n.of(context)!.translationsForLocale().bazaar.businessesFound}'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 6,
            child: ListTile(
              leading: const Icon(Icons.filter_alt),
              title: Text(dic.bazaar.filter),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(builder: (context) => SearchResultsBusinessFiltered(results)),
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
