import 'package:encointer_wallet/page-encointer/common/assignmentPanel.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssigningPage extends StatefulWidget {
  AssigningPage(this.store);

  static const String route = '/encointer/assigning';
  final AppStore store;

  @override
  _AssigningPageState createState() => _AssigningPageState(store);
}

class _AssigningPageState extends State<AssigningPage> {
  _AssigningPageState(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: <Widget>[
        AssignmentPanel(store),
      ]),
    );
  }
}
