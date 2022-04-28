import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/page/account/create/addAccountForm.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage(this.store);

  static const String route = '/account/addAccount';
  final AppStore store;

  @override
  _AddAccountPageState createState() => _AddAccountPageState(store);
}

class _AddAccountPageState extends State<AddAccountPage> {
  _AddAccountPageState(this.store);

  final AppStore store;

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
    await store.addAccount(acc, store.account.newAccount.password, addresses[0]);

    await store.loadAccountCache();

    // fetch info for the imported account
    String pubKey = acc['pubKey'];
    webApi.fetchAccountData();
    webApi.account.fetchAccountsBonded([pubKey]);
    webApi.account.getPubKeyIcons([pubKey]);
    store.setCurrentAccount(pubKey);

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
          title: Container(),
          content: Text(I18n.of(context).translationsForLocale().account.createError),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
            store.account.currentAccount,
            Text(I18n.of(context).translationsForLocale().profile.unlock),
            (password) {
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
  void initState() {
    super.initState();

    if (store.settings.cachedPin.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _showEnterPinDialog(context);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context).translationsForLocale();

    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.addAccount),
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: encointerGrey),
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
                store: store,
              )
            : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
