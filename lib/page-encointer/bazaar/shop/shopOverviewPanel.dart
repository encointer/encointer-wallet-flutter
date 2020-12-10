import 'dart:convert';
import 'dart:async';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:encointer_wallet/service/ipfsApi/httpApi.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shop/shopClass.dart';
import 'package:encointer_wallet/common/consts/settings.dart';

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

  Future<Shop> getShopData(shopID) async {
    final ipfsObject = await Ipfs().getObject(shopID);
    if (ipfsObject != 0) {
      return Shop.fromJson(jsonDecode(ipfsObject)); //store response as string
    } else {
      // in case of invalid IPFS URL
      return Shop(
        name: "dummyShop",
        description: "yet another shop",
        imageHash: "QmXD1TNsVubTgWJiH5yge1JK48Tcb1qif5NsJ3YopX3UQW",
      );
    }
  }

  String getImageAdress(String imageHash) {
    return '$ipfs_gateway_address/ipfs/$imageHash';
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
                            futureShop = getShopData(store.encointer.shopRegistry[index]);
                            return FutureBuilder<Shop>(
                              future: futureShop,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Card(
                                    child: ListTile(
                                      leading: Image.network(
                                        getImageAdress(snapshot.data.imageHash),
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
