import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
import 'package:encointer_wallet/common/components/roundedButton.dart';
import 'package:encointer_wallet/page/account/create/backupAccountPage.dart';
import 'package:encointer_wallet/page/account/create/createAccountForm.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/UI.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage(this.store);

  static final String route = '/account/create';
  final AppStore store;

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState(store);
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  _CreateAccountPageState(this.store);

  final AppStore store;

  bool _submitting = false;
  int _step = 1;

  void _onFinish() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: Column(
            children: <Widget>[
              Image.asset('assets/images/public/dontscreen.png'),
              Container(
                padding: EdgeInsets.only(top: 16, bottom: 24),
                child: Text(
                  I18n.of(context).account['create.warn9'],
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(I18n.of(context).account['create.warn10']),
            ],
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).home['cancel']),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoButton(
              child: Text(I18n.of(context).home['ok']),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, BackupAccountPage.route);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildStep2(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final Map<String, String> i18n = I18n.of(context).account;

    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).home['create']),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              _step = 1;
            });
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(i18n['create.warn1'], style: theme.headline4),
                  ),
                  Text(i18n['create.warn2']),
                  Container(
                    padding: EdgeInsets.only(bottom: 16, top: 32),
                    child: Text(i18n['create.warn3'], style: theme.headline4),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(i18n['create.warn4']),
                  ),
                  Text(i18n['create.warn5']),
                  Container(
                    padding: EdgeInsets.only(bottom: 16, top: 32),
                    child: Text(i18n['create.warn6'], style: theme.headline4),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(i18n['create.warn7']),
                  ),
                  Text(i18n['create.warn8']),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: RoundedButton(
                text: I18n.of(context).home['next'],
                onPressed: _onFinish,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importAccount() async {
    setState(() {
      _submitting = true;
    });
    // var acc = await webApi.account.importAccount(
    //   cryptoType: _advanceOptions.type ?? AccountAdvanceOptionParams.encryptTypeSR,
    //   derivePath: _advanceOptions.path ?? '',
    // );

    await webApi.account.generateAccount();

    var acc = await webApi.account.importAccount(
      cryptoType: AccountAdvanceOptionParams.encryptTypeSR,
      derivePath: '',
    );

    print("Imported Account: ${acc.toString()}");

    if (acc['error'] != null) {
      UI.alertWASM(context, () {
        setState(() {
          _submitting = false;
          _step = 0;
        });
      });
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

    setState(() {
      _submitting = false;
    });
    // go to home page
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    if (_step == 2) {
      return _buildStep2(context);
    }
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context).home['create'])),
      body: SafeArea(
        child: CreateAccountForm(
          setNewAccount: store.account.setNewAccount,
          submitting: false,
          onSubmit: () {
            setState(() {
              // _step = 2;
              _importAccount();
            });
          },
        ),
      ),
    );
  }
}
