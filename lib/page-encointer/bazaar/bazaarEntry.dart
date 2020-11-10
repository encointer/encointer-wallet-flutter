import 'package:encointer_wallet/common/components/BorderedTitle.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BazaarEntry extends StatelessWidget {
  BazaarEntry(this.store);

  final AppStore store;

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
            //Expanded(
            //    child: Observer(
            //        builder: (_) =>
            //            Text(store.encointer.currentPhase.toString()))),
            searchBar(context),
            Container(
              margin: EdgeInsets.all(40),
              child: RoundedButton(
                text: dic['insert.article'] ,
                onPressed: () {
                },
              ),
            ),
            Container(
              child: BorderedTitle(
                title: dic['category.overview'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget searchBar(BuildContext context) {
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
                prefixIcon:
                Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: 30
                ),
                hintText: "What are you looking for?",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}