import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/create_account_form.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage(this.store);

  static const String route = '/account/createAccount';
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
          I18n.of(context)!.translationsForLocale().home.create,
        ),
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.close,
              color: encointerGrey,
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
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
