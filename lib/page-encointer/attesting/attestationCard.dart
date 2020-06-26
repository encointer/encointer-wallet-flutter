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
      var args = {
      "title": 'Your Claim',
      'qrCodeData': widget.claim
      };
      await Navigator.of(context).pushNamed(QrCode.route, arguments: args);
      await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: { 'onScan' : onScan });
    } else {
      await Navigator.of(context).pushNamed(ScanQrCode.route, arguments: { 'onScan' : onScan });
      var args = {
        "title": 'Your Claim',
        'qrCodeData': widget.claim
      };
      await Navigator.of(context).pushNamed(QrCode.route, arguments: args);
    }
  }

  void onScan(String data) async {
    print("Claim received by qrCode:" + data);
    var attestation = await webApi.encointer.attestClaimOfAttendance(data, "123qwe");

    print("Attestation: " +  attestation.toString());
  }

  _revertAttestation() {
    print("reverting attestation");
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    int otherIndex = widget.otherMeetupRegistryIndex;

    var attestation = store.encointer.attestations[otherIndex];
    return RoundedCard(
        border: Border.all(color: Theme.of(context).cardColor),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(children: <Widget>[
          ListTile(
            leading: AddressIcon('', pubKey: attestation.pubKey),
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
