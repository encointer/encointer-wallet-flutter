import 'package:encointer_wallet/page-encointer/bazaar/1_home/BazaarSearch/searchResults.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demoData.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/model/bazaarItemData.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'bazaarSearchAndFilter.dart';

class BazaarSearch extends StatefulWidget {
  const BazaarSearch({Key key}) : super(key: key);

  @override
  _BazaarSearchState createState() => _BazaarSearchState();
}

class _BazaarSearchState extends State<BazaarSearch> {
  final BazaarSearchAndFilter model = BazaarSearchAndFilter(allBazaarItems);
  BazaarItemsWrapper searchResults = BazaarItemsWrapper([], []);
  SearchMode searchMode = SearchMode(SearchDomain.nameAndDescription, Matcher.searchWords);
  String lastQuery;

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 340 : 400,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        lastQuery = query;
        searchResults = model.findItems(query, searchMode);
        setState(() {});
        print(searchResults);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: SearchModeMatcherToggle(searchMode.matcher),
            onPressed: () {
              searchMode = SearchMode(
                  searchMode.searchDomain,
                  (searchMode.matcher == Matcher.searchWords)
                      ? Matcher.searchCharacterSequenceIgnoringCase
                      : Matcher.searchWords);
              setState(() {
                if (lastQuery != null) searchResults = model.findItems(lastQuery, searchMode);
              });
            },
          ),
        ),
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: SearchModeSearchDomainToggle(searchMode.searchDomain),
            onPressed: () {
              searchMode = SearchMode(
                  (searchMode.searchDomain == SearchDomain.nameAndDescription)
                      ? SearchDomain.nameOnly
                      : SearchDomain.nameAndDescription,
                  searchMode.matcher);
              setState(() {
                if (lastQuery != null) searchResults = model.findItems(lastQuery, searchMode);
              });
            },
          ),
        ),
        // FloatingSearchBarAction.searchToClear(
        //   showIfClosed: false,
        // ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: SearchResults(searchResults),
          ),
        );
      },
    );
  }
}

class SearchModeMatcherToggle extends StatelessWidget {
  final Matcher matcher;

  const SearchModeMatcherToggle(this.matcher, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (matcher == Matcher.searchWords) {
      return Text(
        "W",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
      );
    }
    if (matcher == Matcher.searchCharacterSequenceIgnoringCase) {
      return Text(
        "S",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      );
    }
    throw Exception("Matcher for SearchMode not implemented: ($matcher");
  }
}

class SearchModeSearchDomainToggle extends StatelessWidget {
  final SearchDomain searchDomain;

  const SearchModeSearchDomainToggle(this.searchDomain, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchDomain == SearchDomain.nameAndDescription) {
      return Text(
        "N&D",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
      );
    }
    if (searchDomain == SearchDomain.nameOnly) {
      return Text(
        "N",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      );
    }

    throw Exception("SearchDomain for SearchMode not implemented: ($searchDomain");
  }
}
