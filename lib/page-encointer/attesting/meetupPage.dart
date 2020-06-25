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


  void _scanQrCode(int index) {
    print("scanQrCode clicked at index: " + index.toString());
  }

  List<Widget> _buildAccountList(List<String> accounts) {
    return accounts
        .asMap()
        .map((i, account) => MapEntry(i, _buildCard(i, account)))
        .values
        .toList();
  }

  Widget _buildCard(int index, String account) {
    final Map dic = I18n.of(context).encointer;

    return RoundedCard(
        border: Border.all(color: Theme.of(context).cardColor),
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
            children: <Widget>[
              ListTile(
                leading: AddressIcon('', pubKey: account),
                title:  Text(Fmt.address(account)),
                onTap: () => _scanQrCode(index),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                  children: <Widget> [
                    Flexible(
                        child: Column(
                            children: <Widget> [
                              CheckboxListTile(
                                  title: Text(dic['you.attested']),
                                  value: timeDilation != 1.0,
                                  onChanged: (bool value) {
                                    setState(() {});
                                  }),
                              CheckboxListTile(
                                  title: Text(dic['other.attested']),
                                  value: timeDilation != 1.0,
                                  onChanged: (bool value) {
                                  })
                            ]
                        )
                    ),
                    RoundedButton(
                      text: I18n.of(context).home['ok'],
                      onPressed: () {},
                    ),
                  ]
              )
              )
            ]
        )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map dic = I18n.of(context).encointer;

    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    String qrCodeData = args['qrCodeData'];
    List<String> meetupRegistry = args['meetupRegistry'];

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
                    children: _buildAccountList(meetupRegistry),
                  ), // Only numbers can be entered
                ),
              ]
          ),
        )
    );
  }
}


