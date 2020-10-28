import 'package:encointer_wallet/common/components/accountAdvanceOption.dart';
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

  AccountAdvanceOptionParams _advanceOptions = AccountAdvanceOptionParams();
  bool _submitting = false;

  Future<void> _createAndImportAccount() async {
    setState(() {
      _submitting = true;
    });

    await webApi.account.generateAccount();

    var acc = await webApi.account.importAccount(
      cryptoType: _advanceOptions.type ?? AccountAdvanceOptionParams.encryptTypeSR,
      derivePath: _advanceOptions.path ?? '',
    );

    print("Imported Account: ${acc.toString()}");

    if (acc['error'] != null) {
      UI.alertWASM(context, () {
        setState(() {
          _submitting = false;
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
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context).home['create'])),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: CreateAccountForm(
                setNewAccount: store.account.setNewAccount,
                submitting: _submitting,
                onSubmit: () {
                  setState(() {
                    _createAndImportAccount();
                  });
                },
              ),
            ),
            AccountAdvanceOption(
              seed: store.account.newAccount.key ?? '',
              onChange: (data) {
                setState(() {
                  _advanceOptions = data;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
