import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/common/components/roundedCard.dart';
import 'package:encointer_wallet/page-encointer/common/assignmentPanel.dart';
import 'package:encointer_wallet/page-encointer/meetup/startMeetup.dart';
import 'package:encointer_wallet/page/account/txConfirmPage.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AttestingPage extends StatefulWidget {
  AttestingPage(this.store);

  static const String route = '/encointer/attesting';
  final AppStore store;

  @override
  _AttestingPageState createState() => _AttestingPageState(store);
}

class _AttestingPageState extends State<AttestingPage> {
  _AttestingPageState(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;
    return SafeArea(
      child: Column(children: <Widget>[
        AssignmentPanel(store),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: RoundedCard(
            padding: EdgeInsets.all(8),
            child: Column(children: <Widget>[
              Observer(
                builder: (_) => ((store.encointer.meetupIndex == null) | (store.encointer.meetupIndex == 0))
                    ? Text(dic['meetup.not.assigned'])
                    : Container(
                        key: Key('start-meetup'),
                        child: RoundedButton(text: dic['meetup.start'], onPressed: () => startMeetup(context, store))),
              ),
            ]),
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: Observer(
              builder: (_) => RoundedCard(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                      children: <Widget>[
                        Text(dic['claims.scanned'].replaceAll('AMOUNT_PLACEHOLDER', store.encointer.scannedClaimsCount.toString())),
                        ElevatedButton(
                            child: Text(dic['claims.submit']),
                            onPressed: store.encointer.scannedClaimsCount > 0 ?
                                () => _submit(context) :
                            null
                        )
                      ]
                  )
              )
          ),
        )
      ]),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final dic = I18n.of(context).encointer;
    var args = {
      "title": 'attest_claims',
      "txInfo": {
        "module": 'encointerCeremonies',
        "call": 'attestClaims',
        "cid": store.encointer.chosenCid,
      },
      "detail": dic['claims.submit.detail'].replaceAll('AMOUNT', store.encointer.scannedClaimsCount.toString()),
      "params": [store.encointer.participantsClaims.values.toList()],
      'onFinish': (BuildContext txPageContext, Map res) {
        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }
}
