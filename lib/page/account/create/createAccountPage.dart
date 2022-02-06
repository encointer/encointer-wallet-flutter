import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/page-encointer/homePage.dart';
import 'package:encointer_wallet/page/account/create/createAccountForm.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage(this.store);

  static final String route = '/account/createAccount';
  final AppStore store;

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState(store);
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  _CreateAccountPageState(this.store);

  final AppStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            I18n.of(context).home['create'],
            style: Theme.of(context).textTheme.headline3,
          ),
          centerTitle: true,
          leading: Container(),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(0xff666666),
            ),
            onPressed: () {
              Navigator.of(context).popUntil('/');
            },
          )
        ],
      ),
      body: SafeArea(
          child: CreateAccountForm(
        store: store,
      ),
      ),
    );
  }
}
