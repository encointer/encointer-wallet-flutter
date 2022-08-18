import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/account_advance_option_params.dart';
import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/add_account_form.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({Key? key}) : super(key: key);

  static const String route = '/account/addAccount';

  @override
  _AddAccountPageState createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  bool _submitting = false;

  Future<void> _createAndImportAccount() async {
    setState(() {
      _submitting = true;
    });

    await webApi.account.generateAccount();

    var acc = await webApi.account.importAccount(
      cryptoType: AccountAdvanceOptionParams.encryptTypeSR,
      derivePath: '',
    );

    if (acc['error'] != null) {
      setState(() {
        _submitting = false;
      });
      _showErrorCreatingAccountDialog(context);
      return;
    }

    var addresses = await webApi.account.encodeAddress([acc['pubKey']]);
    Log.d("Created new account with address: ${addresses[0]}", 'addAccountPage.dart');
    await context.read<AppStore>().addAccount(acc, context.read<AppStore>().account.newAccount.password, addresses[0]);
    Log.d("added new account with address: ${addresses[0]}", 'addAccountPage.dart');

    String? pubKey = acc['pubKey'];
    await context.read<AppStore>().setCurrentAccount(pubKey);

    await context.read<AppStore>().loadAccountCache();

    // fetch info for the imported account
    webApi.fetchAccountData();
    webApi.account.getPubKeyIcons([pubKey]);

    setState(() {
      _submitting = false;
    });
    // go to home page
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  static Future<void> _showErrorCreatingAccountDialog(BuildContext context) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const SizedBox(),
          content: Text(I18n.of(context)!.translationsForLocale().account.createError),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEnterPinDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return Container(
          child: showPasswordInputDialog(
            context,
            context.read<AppStore>().account.currentAccount,
            Text(I18n.of(context)!.translationsForLocale().profile.unlock),
            (password) {
              setState(() {
                context.read<AppStore>().settings.setPin(password);
              });
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (context.read<AppStore>().settings.cachedPin.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _showEnterPinDialog(context);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.addAccount),
        leading: const SizedBox(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: encointerGrey),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          )
        ],
      ),
      body: SafeArea(
        child: !_submitting
            ? AddAccountForm(
                submitting: _submitting,
                onSubmit: () {
                  setState(() {
                    _createAndImportAccount();
                  });
                },
                store: context.read<AppStore>(),
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
