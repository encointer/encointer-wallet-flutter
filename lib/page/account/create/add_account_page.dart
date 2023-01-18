import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/add_account_form.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:translation_package/translation_package.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  static const String route = '/account/addAccount';

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  bool _submitting = false;
  late final AppStore _appStore;

  @override
  void initState() {
    super.initState();
    _appStore = context.read<AppStore>();
    if (_appStore.settings.cachedPin.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _showEnterPinDialog(_appStore);
        });
      });
    }
  }

  Future<void> _createAndImportAccount(AppStore store) async {
    setState(() {
      _submitting = true;
    });

    await webApi.account.generateAccount();

    final acc = await webApi.account.importAccount();

    if (acc['error'] != null) {
      setState(() {
        _submitting = false;
      });
      _showErrorCreatingAccountDialog(context);
      return;
    }

    final addresses = await webApi.account.encodeAddress([acc['pubKey'] as String]);
    Log.d('Created new account with address: ${addresses[0]}', 'AddAccountPage');

    await store.addAccount(acc, store.account.newAccount.password, addresses[0]);
    Log.d('added new account with address: ${addresses[0]}', 'AddAccountPage');

    final pubKey = acc['pubKey'] as String?;
    await store.setCurrentAccount(pubKey);

    await store.loadAccountCache();

    // fetch info for the imported account
    webApi.fetchAccountData();

    setState(() {
      _submitting = false;
    });
    // go to home page
    Navigator.pop(context);
  }

  static Future<void> _showErrorCreatingAccountDialog(BuildContext context) async {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: Text(I18n.of(context)!.translationsForLocale().account.createError),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEnterPinDialog(AppStore store) async {
    await showCupertinoDialog<void>(
      context: context,
      builder: (_) {
        return Container(
          child: showPasswordInputDialog(
            context,
            store.account.currentAccount,
            Text(I18n.of(context)!.translationsForLocale().profile.unlock),
            (String password) {
              setState(() {
                store.settings.setPin(password);
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.addAccount),
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: encointerGrey),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SafeArea(
        child: !_submitting
            ? AddAccountForm(
                submitting: _submitting,
                onSubmit: () {
                  setState(() {
                    _createAndImportAccount(context.read<AppStore>());
                  });
                },
                store: context.watch<AppStore>(),
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
