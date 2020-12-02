import 'dart:convert';
import 'dart:async';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:encointer_wallet/service/ipfsApi/http_api.dart';

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
    Ipfs ipfs = Ipfs();

    String cid = "QmZYzDFgKW6eABU2QXCExigm3LTkkWRaUhPJEBJhA6nBWN";
    // return json
    final ipfsObject = ipfs.getObject(cid);
    // ipfsObject must be a String (json)
    String jsonFile = ipfsObject.toString();
    print(jsonFile);
    var shop = Shop.fromJson(jsonDecode(jsonFile)); //store response as string
    print(shop.name.toString());
    return shop;
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
                                      /*leading: Image.network(
                                        snapshot.data.image,
                                        fit: BoxFit.fill,
                                        width: 100,
                                        height: 100,
                                        alignment: Alignment.center,
                                      ),*/
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
