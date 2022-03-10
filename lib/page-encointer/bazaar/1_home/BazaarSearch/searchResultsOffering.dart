import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaarItemVertical.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'searchResultsOfferingFiltered.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class SearchResultsOffering extends StatelessWidget {
  final results;

  const SearchResultsOffering(this.results, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Translations dic = I18n.of(context).translationsForLocale();
    return Scaffold(
      appBar: AppBar(
        title: Text("${results.length} ${I18n.of(context).translationsForLocale().bazaar.offeringsFound}"),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 6,
            child: ListTile(
              leading: Icon(Icons.filter_alt),
              title: Text(dic.bazaar.filter),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
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
