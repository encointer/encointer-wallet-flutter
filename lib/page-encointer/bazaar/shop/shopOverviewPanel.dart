import 'dart:convert';
import 'dart:async';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:http/http.dart' as http; //TODO: change to IPFS

class ShopOverviewPanel extends StatefulWidget {
  ShopOverviewPanel(this.store);

  static const String route = '/encointer/bazaar/shopOverviewPanel';
  final AppStore store;

  @override
  _ShopOverviewPanelState createState() => _ShopOverviewPanelState(store);
}

class _ShopOverviewPanelState extends State<ShopOverviewPanel> {
  _ShopOverviewPanelState(this.store);

  final AppStore store;
  Future<Shop> futureShop;

  Future<Shop> getData(shopID) async {
    final response = await http.get(shopID);

    //if response is 200 : success that store
    if (response.statusCode == 200) {
      return Shop.fromJson(jsonDecode(response.body)); //store response as string
    } else {
      // create dummy shop
      return Shop(
        name: "dummyShop",
        description: "yet another shop",
        image: "https://www.loreal-finance.com/site/RA2014/img/desktop/data/body-shop-pic3.jpg",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RoundedCard(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Text("Show shops:"),
            Observer(
              builder: (_) => (store.encointer.shopRegistry == null)
                  ? CupertinoActivityIndicator()
                  : (store.encointer.shopRegistry.isEmpty)
                      ? Text("no shops found")
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: store.encointer.shopRegistry == null ? 0 : store.encointer.shopRegistry.length,
                          itemBuilder: (BuildContext context, int index) {
                            futureShop = getData(store.encointer.shopRegistry[index]);
                            return FutureBuilder<Shop>(
                              future: futureShop,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Card(
                                    child: ListTile(
                                      leading: Image.network(
                                        snapshot.data.image,
                                        fit: BoxFit.fill,
                                        width: 100,
                                        height: 100,
                                        alignment: Alignment.center,
                                      ),
                                      title: Text(snapshot.data.name),
                                      subtitle: Text(snapshot.data.description),
                                    ),
                                  );
                                  //return Text(snapshot.data.name);
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                // By default, show a loading spinner.
                                return CircularProgressIndicator();
                              },
                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}

class Shop {
  final String name;
  final String description;
  final String image;

  Shop({this.name, this.description, this.image});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
