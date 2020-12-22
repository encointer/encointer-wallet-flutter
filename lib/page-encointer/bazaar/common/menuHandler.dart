import 'package:flutter/material.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MenuHandler extends StatelessWidget {
  MenuHandler(this.store);

  BuildContext context;
  final AppStore store;

  void _dismiss() {
    Navigator.pop(context);
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
              child: SingleChildScrollView(
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
                          title: Text(Fmt.currencyIdentifier(store.encointer.currencyIdentifiers[index])),
                          onTap: () {},
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
