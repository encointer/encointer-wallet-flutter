import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:polka_wallet/common/components/BorderedTitle.dart';
import 'package:polka_wallet/common/components/addressIcon.dart';
import 'package:polka_wallet/common/components/roundedButton.dart';
import 'package:polka_wallet/common/components/roundedCard.dart';
import 'package:polka_wallet/store/app.dart';
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

  @override
  void initState() {
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
                      Text(
                        dic['encointer'] ?? 'Encointer Platform',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme
                              .of(context)
                              .cardColor,
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
              ]
          ),
        )
    );
  }
}


