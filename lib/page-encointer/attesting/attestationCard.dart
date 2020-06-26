import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:polka_wallet/common/components/BorderedTitle.dart';
import 'package:polka_wallet/common/components/addressIcon.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/store/app.dart';
import 'package:polka_wallet/utils/format.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

class AttestationCard extends StatefulWidget {
  AttestationCard(this.store, this.attestatopm);

  static const String route = '/encointer/meetup/';
  final AppStore store;

  final int attestatopm;

  @override
  _AttestationCardState createState() => _AttestationCardState(store, attestatopm);
}

class _AttestationCardState extends State<AttestationCard> {
  _AttestationCardState(this.store, this.meetupRegistryIndex);

  final AppStore store;
  var _amountAttendees;
  final int meetupRegistryIndex;

  void _scanQrCode(int index) {
    print("scanQrCode clicked at index: " + index.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n
        .of(context)
        .encointer;

    var attestation = store.encointer.attestations[meetupRegistryIndex];
    return RoundedCard(
        border: Border.all(color: Theme
            .of(context)
            .cardColor),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
            children: <Widget>[
              ListTile(
                leading: AddressIcon('', pubKey: attestation.pubKey),
                title: Text(Fmt.address(attestation.pubKey)),
                onTap: () => _scanQrCode(meetupRegistryIndex),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                      children: <Widget>[
                        Flexible(
                            child: Column(
                                children: <Widget>[
                                  Observer(
                                  builder: (_) => CheckboxListTile(
                                      title: Text(dic['you.attested']),
                                      value: store.encointer.attestations[meetupRegistryIndex].attestedOther,
                                      selected: store.encointer.attestations[meetupRegistryIndex].attestedOther,
                                      onChanged: (bool value) {
                                        setState(() {
                                          attestation.switchState();
                                        });
                                      }),
                                  ),
                                  Observer(
                                    builder: (_) => CheckboxListTile(
                                        title: Text(dic['you.attested']),
                                        value: store.encointer.attestations[meetupRegistryIndex].attestedOther,
                                        selected: store.encointer.attestations[meetupRegistryIndex].attestedOther,
                                        onChanged: (bool value) {
                                          setState(() {});
                                        }),
                                  ),
                                ]
                            )
                        ),
                        RoundedButton(
                          text: I18n
                              .of(context)
                              .home['ok'],
                          onPressed: () {},
                        ),
                      ]
                  )
              )
            ]
        )
    );
  }
}
