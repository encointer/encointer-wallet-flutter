import 'package:encointer_wallet/page-encointer/common/assignmentPanel.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
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
    final Translations dic = I18n.of(context).translationsForLocale();
    return SafeArea(
      child: Column(children: <Widget>[
        AssignmentPanel(store),
      ]),
    );
  }
}
