import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:polka_wallet/common/components/BorderedTitle.dart';
import 'package:polka_wallet/common/components/addressIcon.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/page-encointer/attesting/qrCode.dart';
import 'package:polka_wallet/page-encointer/attesting/scanQrCode.dart';
import 'package:polka_wallet/page/account/scanPage.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/store/encointer/types/attestation.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class AttestationCard extends StatefulWidget {
  AttestationCard(
    this.store, {
    this.myMeetupRegistryIndex,
    this.otherMeetupRegistryIndex,
    this.claim,
  });

  static const String route = '/encointer/meetup/';
  final AppStore store;

  final int myMeetupRegistryIndex;
  final int otherMeetupRegistryIndex;
  final String claim;

  @override
  _AttestationCardState createState() => _AttestationCardState(store);
}

class _AttestationCardState extends State<AttestationCard> {
  _AttestationCardState(this.store);

  final AppStore store;

  void _scanQrCode(int index) {
    print("scanQrCode clicked at index: " + index.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  _performAttestation() async {
    print("performing attestation");
    if (widget.myMeetupRegistryIndex < widget.otherMeetupRegistryIndex) {
      //show claimA
      print("I'm party A. showing my claim now");
      var args = {
      "title": 'Your Claim',
      'qrCodeData': widget.claim
      };
      await Navigator.of(context).pushNamed(QrCode.route, arguments: args);

      // scan AttestationA | claimB
      var attestationAClaimB = await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: { 'onScan' : onScan });
      var attCla = attestationAClaimB.toString().split(':');
      print("Attestation received by QR code: " + attCla[0]);
      print("Claim received by qrCode:" + attCla[1]);

      // store AttestationA (my claim, attested by other)
      store.encointer.attestations[widget.otherMeetupRegistryIndex].yourAttestation = attCla[0];

      // attest claimB
      Map attestationB = await webApi.encointer.attestClaimOfAttendance(attCla[0], "123qwe");
      print("aat: " + attestationB['attestation'].toString());
      // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
      // store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(attestationB['attestation']);
      print("Attestation: " + attestationB.toString());

      // show attestationB
      var args2 = {
        "title": 'Attestation from Other',
        'qrCodeData': attestationB['attestationHex'].toString(),
      };
      await Navigator.of(context).pushNamed(QrCode.route, arguments: args2);

    } else {
      // scanning claim A
      print("I'm party B. scanning others' claimA now");
      var claimA = await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: { 'onScan' : onScan });
      print("Received Claim A: " + claimA.toString());

      // attest claimA
      Map res = await webApi.encointer.attestClaimOfAttendance(claimA, "123qwe");
      print("aat: " + res['attestation'].toString());
      // currently, parsing attestation fails, as it is returned as an `Attestation` from the js_service which implies the the location is in I32F32
//      store.encointer.attestations[widget.otherMeetupRegistryIndex].otherAttestation = Attestation.fromJson(res['attestation']);
      print("Attestation: " + res.toString());

      // show AttestationA | claimB
      var args = {
        "title": 'other Attestation | my claim',
        'qrCodeData': res['attestationHex'].toString() + ":" + widget.claim,
      };
      await Navigator.of(context).pushNamed(QrCode.route, arguments: args);

      // scan AttestationB
      var attB = await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: { 'onScan' : onScan });
      print("Received AttestastionB: " + attB.toString());
      // store AttestationB (my claim, attested by other)
      //store.encointer.attestations[widget.otherMeetupRegistryIndex].yourAttestation = Attestation.fromJson(json.decode(attB));
      store.encointer.attestations[widget.otherMeetupRegistryIndex].yourAttestation = attB.toString();
    }
  }

  Future<String> onScan(String data) async {
    return data;
  }

  _revertAttestation() {
    print("reverting attestation");
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    int otherIndex = widget.otherMeetupRegistryIndex;

    var attestation = store.encointer.attestations[otherIndex];
    print("Attestationcard for " + attestation.pubKey);
    return RoundedCard(
        border: Border.all(color: Theme.of(context).cardColor),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(children: <Widget>[
          ListTile(
            leading: Container(
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
              child: Text(otherIndex.toString())   //AddressIcon(attestation.pubKey, size: 64),
            ),
            title: Text(Fmt.address(attestation.pubKey)),
            onTap: () => _scanQrCode(otherIndex),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(children: <Widget>[
                Flexible(
                    child: Column(children: <Widget>[
                  Observer(
                    builder: (_) => CheckboxListTile(
                        title: Text(dic['you.attested']),
                        value: store
                            .encointer.attestations[otherIndex].attestedOther,
                        selected: store
                            .encointer.attestations[otherIndex].attestedOther,
                        onChanged: (bool value) {
                          setState(() {
                            attestation.switchState();
                          });
                        }),
                  ),
                  Observer(
                    builder: (_) => CheckboxListTile(
                        title: Text(dic['other.attested']),
                        value: store
                            .encointer.attestations[otherIndex].attestedOther,
                        selected: store
                            .encointer.attestations[otherIndex].attestedOther,
                        onChanged: (bool value) {
                          setState(() {});
                        }),
                  ),
                ])),
                Observer(
                  builder: (_) => RoundedButton(
                    text: store.encointer.attestations[otherIndex].complete
                        ? dic['attestation.revert']
                        : dic['attestation.perform'],
                    onPressed:
                        !store.encointer.attestations[otherIndex].complete
                            ? () => _performAttestation()
                            : () => _revertAttestation(),
                  ),
                )
              ]))
        ]));
  }
}
