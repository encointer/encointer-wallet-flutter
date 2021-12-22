import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/bazaarItemVertical.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaarItemData.dart';

import 'searchResultsBusiness.dart';
import 'searchResultsOffering.dart';

class SearchResults extends StatelessWidget {
  final BazaarItemsWrapper searchResults;

  const SearchResults(
    this.searchResults, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var topResults = [
      if (searchResults.businesses.isNotEmpty) searchResults.businesses[0],
      if (searchResults.offerings.isNotEmpty) searchResults.offerings[0],
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResultSummaryListTile(searchResults.businesses, "Results in Businesses"),
        ResultSummaryListTile(searchResults.offerings, "Results in Offerings"),
        Text(
          "Top Results",
          style: TextStyle(fontWeight: FontWeight.bold, height: 2.5),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            topResults.length,
            (int index) {
              return BazaarItemVertical(
                data: topResults,
                index: index,
                cardHeight: 125,
              );
            },
          ),
        ),
      ],
    );
  }
}

class ResultSummaryListTile extends StatelessWidget {
  final List<BazaarItemData> results;
  final title;

  const ResultSummaryListTile(
    this.results,
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 30,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              results.length.toString(),
            ),
          ],
        ),
      ),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                (results[0] is BazaarBusinessData) ? SearchResultsBusiness(results) : SearchResultsOffering(results),
          ),
        );
      }, // TODO state management
    );
  }
}
