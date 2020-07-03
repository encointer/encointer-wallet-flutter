import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:polka_wallet/common/components/BorderedTitle.dart';
import 'package:polka_wallet/common/components/addressIcon.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/page/account/txConfirmPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestation.dart';
import 'package:polka_wallet/store/encointer/types/location.dart';
import 'package:polka_wallet/utils/UI.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

import 'attestationCard.dart';

class MeetupPage extends StatefulWidget {
  MeetupPage(this.store);

  static const String route = '/encointer/meetup/';
  final AppStore store;

  @override
  _MeetupPageState createState() => _MeetupPageState(store);
}

class _MeetupPageState extends State<MeetupPage> {
  _MeetupPageState(this.store);

  final AppStore store;
  var _amountAttendees;

  List<Widget> _buildAttestationCardList(String claim) {
    return store.encointer.attestations
        .map((i, _) => MapEntry(
            i,
            AttestationCard(
              store,
              myMeetupRegistryIndex: store.encointer.myMeetupRegistryIndex,
              otherMeetupRegistryIndex: i,
              claim: claim,
            )))
        .values
        .toList();
  }

  Future<void> _submit(BuildContext context) async {
    print("All attestations full: " + store.encointer.attestations.toString());
    /*var attestations = store.encointer.attestations
      .map((key, value) => MapEntry(key, value.yourAttestation))
        .values
        .where((x) => x != null)
        .toList();
*/
    const claimTest = '0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d3f00000022c51e6a656b19dd1e34c6126a75b8af02b38eedbeec51865063f142c83d40d301000000000000002aacf17b230000000000268b120000006da47bd57201000003000000';
    Map res = await webApi.encointer.attestClaimOfAttendance(claimTest, "123qwe");
    List<Attestation> attestations = new List();
    attestations.add(Attestation.fromJson(res['attestation']));
    attestations.add(Attestation.fromJson(res['attestation']));
    //attestations = [
    //  "0xbe9db4ecc6821c60f81a38c50526c971a94901368555b64e091da9bca8e7cc7ffb0f0000cef98d744e978f3e33724cfb5677d2104e020909fbec6e97c2c594aa607d78cb010000000000000000000000000000000000000000000000a07a2113730100000a000000a22d93c78073c7a1923a4dad3a1a186c0aa8135a86e6ff40612029bfade5423ced9a032c18c0023501ed0bde364d6fd25ce0853d3ae0d191a17b9f0304089b8abe9db4ecc6821c60f81a38c50526c971a94901368555b64e091da9bca8e7cc7f",
    //  "0xbe9db4ecc6821c60f81a38c50526c971a94901368555b64e091da9bca8e7cc7ffb0f0000cef98d744e978f3e33724cfb5677d2104e020909fbec6e97c2c594aa607d78cb010000000000000000000000000000000000000000000000a07a2113730100000a000000a22d93c78073c7a1923a4dad3a1a186c0aa8135a86e6ff40612029bfade5423ced9a032c18c0023501ed0bde364d6fd25ce0853d3ae0d191a17b9f0304089b8abe9db4ecc6821c60f81a38c50526c971a94901368555b64e091da9bca8e7cc7f"
    //];
    print("All attestations flat: " + jsonEncode(attestations));
    //return;
    var args = {
      "title": 'register_attestations',
      "txInfo": {
        "module": 'encointerCeremonies',
        "call": 'registerAttestations',
      },
      "detail": jsonEncode({
        "attestations": attestations,
      }),
      "params": [
        attestations,
      ],
      'onFinish': (BuildContext txPageContext, Map res) {
        Navigator.popUntil(txPageContext, ModalRoute.withName('/'));
        globalBalanceRefreshKey.currentState.show();
      }
    };
    Navigator.of(context).pushNamed(TxConfirmPage.route, arguments: args);
  }

  @override
  void initState() {
    //store.encointer.setNextMeetupLocation(Location(0, 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    String claim = args['claim'];

    return Scaffold(
        appBar: AppBar(
          title: Text(dic['ceremony']),
          centerTitle: true,
        ),
        backgroundColor:Theme.of(context).canvasColor,
        body: SafeArea(
          child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("myself: "),
                      //AddressIcon(store.account.currentAddress, size: 64),
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(8.0),
                          //color: Colors.lime,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Text(store.encointer.myMeetupRegistryIndex.toString())   //AddressIcon(attestation.pubKey, size: 64),
                      ),
                      Text(
                        Fmt.address(store.account.currentAddress),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    children: _buildAttestationCardList(claim),
                  ), // Only numbers can be entered
                ),
                RoundedButton(
                  text: dic['meetup.complete'],
                  onPressed: () =>  _submit(context)
                )
              ]
          ),
        )
    );
  }
}


