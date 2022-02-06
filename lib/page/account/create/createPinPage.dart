import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/page-encointer/homePage.dart';
import 'package:encointer_wallet/page/account/create/createPinForm.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage(this.store);

  static final String route = '/account/createPin';
  final AppStore store;

  @override
  _CreatePinPageState createState() => _CreatePinPageState(store);
}

class _CreatePinPageState extends State<CreatePinPage> {
  _CreatePinPageState(this.store);

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

    await store.account.addAccount(acc, store.account.newAccount.password);
    webApi.account.encodeAddress([acc['pubKey']]);

    store.assets.loadAccountCache();

    // fetch info for the imported account
    String pubKey = acc['pubKey'];
    webApi.assets.fetchBalance();
    webApi.account.fetchAccountsBonded([pubKey]);
    webApi.account.getPubKeyIcons([pubKey]);
    store.account.setCurrentAccount(pubKey);

    setState(() {
      _submitting = false;
    });
    // go to home page
    Navigator.popUntil(context, ModalRoute.withName('/'));
    // pass the encointerHomepage context, else Navigator.pop() acts on this context, which has been invalidated.
    _showTryFaucetDialog(EncointerHomePage.encointerHomePageKey.currentContext);
  }

  Future<void> _showTryFaucetDialog(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context).encointer['faucet.try']),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).home['ok']),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> _showErrorCreatingAccountDialog(BuildContext context) async {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: Text(I18n.of(context).account['create.error']),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).home['ok']),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    print("the name is: ${args['name']}");
    return Scaffold(
      appBar: AppBar(
          title: Text(
            I18n.of(context).home['create'],
            style: Theme.of(context).textTheme.headline3,
          ),
          iconTheme: IconThemeData(
            color: Color(0xff666666), //change your color here
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent
      ),
      body: SafeArea(
        child: !_submitting
            ? CreatePinForm(
                setNewAccount: store.account.setNewAccount,
                submitting: _submitting,
                onSubmit: () {
                  setState(() {
                    _createAndImportAccount();
                  });
                },
                store: store,
                name: args['name'],
              )
            : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
