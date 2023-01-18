import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/create_account_form.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:translation_package/translation_package.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  static const String route = '/account/createAccount';

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SafeArea(
        child: CreateAccountForm(
          store: context.watch<AppStore>(),
        ),
      ),
    );
  }
}
