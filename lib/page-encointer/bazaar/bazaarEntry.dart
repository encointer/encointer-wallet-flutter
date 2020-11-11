import 'package:encointer_wallet/common/components/BorderedTitle.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page-encointer/bazaar/components/itemCard.dart';
import 'package:encointer_wallet/page-encointer/bazaar/components/articleClass.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BazaarEntry extends StatelessWidget {
  BazaarEntry(this.store);

  final AppStore store;

  // dummy List creation
  List<Article> dummyList = createDummyList();
  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).bazaar;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dic['bazaar.title'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            searchBar(context, dic),
            Container(
              margin: EdgeInsets.only(left: 5, top: 15),
              child: articleInclusion(context, dic, dummyList),
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchBar(BuildContext context, Map dic) {
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 40, right: 40, top: 15),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 8,
          child: Container(
            child: TextFormField(
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor, size: 30),
                hintText: dic['looking.for'],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget articleInclusion(BuildContext context, Map dic, List<Article> itemList) {
  final double _height = MediaQuery.of(context).size.height;
  return Column(
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40),
            child: BorderedTitle(
              title: dic['article'],
            ),
          ),
        ],
      ),
      Container(
        height: _height / 5,
        child: ListView.builder(
          padding: EdgeInsets.all(5),
          shrinkWrap: true,
          itemCount: itemList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, index) {
            return _buildEntries(context, index, itemList);
          },
        ),
      ),
      Container(
        margin: EdgeInsets.all(40),
        child: RoundedButton(
          text: dic['article.insert'],
          onPressed: () {},
        ),
      ),
    ],
  );
}

Widget _buildEntries(BuildContext context, int index, List<Article> itemList) {
  return GestureDetector(
    onTap: () {
      // Navigator.of(context).pushNamed(DETAIL_UI);
    },
    child: ItemCard(
      title: '${itemList[index].title}',
      category: 'dummy',
      price: "₹${itemList[index].price}",
      dateAdded: "${itemList[index].dateAdded}",
      description: "${itemList[index].desc}",
      image: "${itemList[index].image}",
      location: "${itemList[index].location}",
    ),
  );
}

List<Article> createDummyList() {
  List<Article> dummyItems;
  return dummyItems = [
    Article(123, "02 Apr 2019", "Lenovo T450", "Best Item ever", 40000, 0795419141,
        "assets/images/public/logo_about.png", "Zurich"),
    Article(
        124, "02 Apr 2019", "Bread", "Best Item ever", 10, 0795419141, "assets/images/public/logo_about.png", "Zurich"),
    Article(
        125, "05 Mai 2019", "Kohlrabi", "Hmm..! Fein", 10, 0795419141, "assets/images/public/logo_about.png", "Zurich"),
    Article(
        126, "10 Mai 2019", "Coffee", "Hmm..! Fein", 10, 0795419141, "assets/images/public/logo_about.png", "Zurich"),
  ];
}
