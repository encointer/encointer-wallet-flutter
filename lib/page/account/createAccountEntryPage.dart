import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/create/createAccountPage.dart';
import 'package:encointer_wallet/page/account/import/importAccountPage.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';

class CreateAccountEntryPage extends StatelessWidget {
  static final String route = '/account/entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(title: Text(I18n.of(context).home['create'])),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset('assets/images/public/logo_about.png'),
            ),
            Padding(
              key: Key('create-account'),
              padding: EdgeInsets.all(16),
              child: RoundedButton(
                text: I18n.of(context).home['create'],
                onPressed: () {
                  Navigator.pushNamed(context, CreateAccountPage.route);
                },
              ),
            ),
            Padding(
              key: Key('import-account'),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: RoundedButton(
                text: I18n.of(context).home['import'],
                onPressed: () {
                  Navigator.pushNamed(context, ImportAccountPage.route);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
