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
    Map dic = I18n.of(context).encointer;
    return SafeArea(
      child: Column(children: <Widget>[
        AssignmentPanel(store),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          child: RoundedCard(
            padding: EdgeInsets.all(8),
            child: Column(children: <Widget>[
              // Observer(builder: (_) => _reportAttestationsCount(context, store.encointer.attestations)),
              Observer(
                builder: (_) => ((store.encointer.meetupIndex == null) | (store.encointer.meetupIndex == 0))
                    ? Text(dic['meetup.not.assigned'])
                    : Container(
                        key: Key('start-meetup'),
                        child: RoundedButton(text: dic['meetup.start'], onPressed: () => startMeetup(context, store))),
              )
            ]),
          ),
        )
      ]),
    );
  }

  /// Todo: use `attest_claims`
  Future<void> _submit(BuildContext context) async {
    var args = {
      "title": 'register_attestations',
      "txInfo": {
        "module": 'encointerCeremonies',
        "call": 'registerAttestations',
        "cid": store.encointer.chosenCid,
      },
      // "detail": "submitting ${attestations.length} attestations for the recent ceremony ",
      // "params": [attestations],
//      "rawParam": '[[${attestationsHex.join(',')}]]',
//      "rawParam": '[$attestations]',
      'onFinish': (BuildContext txPageContext, Map res) {
        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }
}
