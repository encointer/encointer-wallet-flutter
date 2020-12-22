import 'package:flutter/material.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CurrencyChooserHandler extends StatefulWidget {
  CurrencyChooserHandler(this.store);

  final AppStore store;

  @override
  _CurrencyChooserHandlerState createState() => _CurrencyChooserHandlerState(store);
}

class _CurrencyChooserHandlerState extends State<CurrencyChooserHandler> {
  _CurrencyChooserHandlerState(this.store);

  BuildContext context;
  final AppStore store;

  void _setStateAndReturn(var newCid) {
    setState(() {
      store.encointer.setChosenCid(newCid);
    });
    Navigator.pop(context, newCid);
  }

  void _dismiss() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    final Map<String, String> dic = I18n.of(context).bazaar;

    return GestureDetector(
        onTap: () {
          _dismiss(); // return when tapped on background
        },
        child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.85),
            body: Opacity(
              opacity: 1,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                padding: EdgeInsets.fromLTRB(10, 50, 100, 50),
                child: RoundedCard(
                  child: Observer(
                    builder: (_) => (store.encointer.currencyIdentifiers == null)
                        ? CupertinoActivityIndicator()
                        : (store.encointer.currencyIdentifiers.isEmpty)
                            ? Text("no currencies found")
                            : SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    RoundedCard(
                                        child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset('assets/images/assets/ERT.png'),
                                        ),
                                        Container(width: 15),
                                        Text(
                                          dic['choose.currency'],
                                        ),
                                      ],
                                    )),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      //padding: const EdgeInsets.all(8.0),
                                      itemCount: store.encointer.currencyIdentifiers.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(
                                          title:
                                              Text(Fmt.currencyIdentifier(store.encointer.currencyIdentifiers[index])),
                                          onTap: () {
                                            _setStateAndReturn(store.encointer.currencyIdentifiers[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                  ),
                ),
              ),
            )));

    /*return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.85),
        body: Opacity(
          opacity: 1,
          child: Container(
            width: double.infinity,
            child: RoundedCard(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: <Widget>[
                  Text("Choose currency:"),
                  Observer(
                    builder: (_) => (store.encointer.currencyIdentifiers == null)
                        ? CupertinoActivityIndicator()
                        : (store.encointer.currencyIdentifiers.isEmpty)
                            ? Text("no currencies found")
                            : DropdownButton<dynamic>(
                                value: (store.encointer.chosenCid == null ||
                                        !store.encointer.currencyIdentifiers.contains(store.encointer.chosenCid))
                                    ? store.encointer.currencyIdentifiers[0]
                                    : store.encointer.chosenCid,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 32,
                                elevation: 32,
                                onChanged: (newValue) {
                                  _setStateAndReturn(newValue);
                                },
                                items: store.encointer.currencyIdentifiers
                                    .map<DropdownMenuItem<dynamic>>((value) => DropdownMenuItem<dynamic>(
                                          value: value,
                                          child: Text(Fmt.currencyIdentifier(value)),
                                        ))
                                    .toList(),
                              ),
                  ),
                ],
              ),
            ),
          ),
        ));*/
  }

  Widget roundedButton(String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(100.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }
}
