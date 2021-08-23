import 'dart:async';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:encointer_wallet/page-encointer/bazaar/business/businessClass.dart';
import 'package:encointer_wallet/config/consts.dart';

class BusinessOverviewPanel extends StatefulWidget {
  BusinessOverviewPanel(this.store);

  static const String route = '/encointer/bazaar/businessOverviewPanel';
  final AppStore store;

  @override
  _BusinessOverviewPanelState createState() => _BusinessOverviewPanelState(store);
}

class _BusinessOverviewPanelState extends State<BusinessOverviewPanel> {
  _BusinessOverviewPanelState(this.store);

  final AppStore store;
  Future<Business> futureBusiness;

  String getImageAdress(String imageHash) {
    return '$ipfs_gateway_encointer/ipfs/$imageHash';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: RoundedCard(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Observer(
            builder: (_) => (store.encointer.businessRegistry == null)
                ? CupertinoActivityIndicator()
                : (store.encointer.businessRegistry.isEmpty)
                    ? Text("no businesses found")
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 100),
                        itemCount: store.encointer.businessRegistry == null ? 0 : store.encointer.businessRegistry.length,
                        itemBuilder: (BuildContext context, int index) {
                          futureBusiness = Business().getBusinessData(store.encointer.businessRegistry[index]);
                          return FutureBuilder<Business>(
                            future: futureBusiness,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Card(
                                  child: ListTile(
                                    leading: Image.network(
                                      getImageAdress(snapshot.data.imageHash),
                                      fit: BoxFit.fill,
                                      width: 85,
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
          ),
        ),
      ),
    );
  }
}
