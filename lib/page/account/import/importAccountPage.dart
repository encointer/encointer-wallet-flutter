import 'package:encointer_wallet/page/account/create/createPinPage.dart';
import 'package:encointer_wallet/page/account/import/importAccountForm.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImportAccountPage extends StatefulWidget {
  const ImportAccountPage(this.store);

  static const String route = '/account/import';
  final AppStore store;

  @override
  _ImportAccountPageState createState() => _ImportAccountPageState(store);
}

class _ImportAccountPageState extends State<ImportAccountPage> {
  _ImportAccountPageState(this.store);

  final AppStore store;

  String _keyType = '';
  String _cryptoType = '';
  String _derivePath = '';
  bool _submitting = false;

  final TextEditingController _nameCtrl = new TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _importAccount() async {
    setState(() {
      _submitting = true;
    });
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context).translationsForLocale().home.loading),
          content: Container(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );

    /// import account
    var acc = await webApi.account.importAccount(
      keyType: _keyType,
      cryptoType: _cryptoType,
      derivePath: _derivePath,
    );

    // check if account duplicate
    if (acc != null) {
      if (acc['error'] != null) {
        var msg = acc['error'];

        if (acc['error'] == 'unreachable') {
          msg = "${I18n.of(context).translationsForLocale().account.importInvalid}: $_keyType";
        }

        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Container(),
              content: Text('$msg'),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context).translationsForLocale().home.ok),
                  onPressed: () {
                    setState(() {
                      _submitting = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
      _checkAccountDuplicate(acc);
      return;
    }

    // account == null
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        final Translations dic = I18n.of(context).translationsForLocale();
        return CupertinoAlertDialog(
          title: Container(),
          content: Text('${dic.account.importInvalid} ${dic.account.createPassword}'),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context).translationsForLocale().home.cancel),
              onPressed: () {
                setState(() {
                  _submitting = false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkAccountDuplicate(Map<String, dynamic> acc) async {
    int index = store.account.accountList.indexWhere((i) => i.pubKey == acc['pubKey']);
    if (index > -1) {
      Map<String, String> pubKeyMap = store.account.pubKeyAddressMap[store.settings.endpoint.ss58];
      String address = pubKeyMap[acc['pubKey']];
      if (address != null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(Fmt.address(address)),
              content: Text(I18n.of(context).translationsForLocale().account.importDuplicate),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context).translationsForLocale().home.cancel),
                  onPressed: () {
                    setState(() {
                      _submitting = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: Text(I18n.of(context).translationsForLocale().home.ok),
                  onPressed: () {
                    _saveAccount(acc);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      _saveAccount(acc);
    }
  }

  Future<void> _saveAccount(Map<String, dynamic> acc) async {
    var addresses = await webApi.account.encodeAddress([acc['pubKey']]);
    await store.addAccount(acc, store.account.newAccount.password, addresses[0]);

    await store.loadAccountCache();

    // fetch info for the imported account
    String pubKey = acc['pubKey'];
    webApi.fetchAccountData();
    webApi.account.fetchAccountsBonded([pubKey]);
    webApi.account.getPubKeyIcons([pubKey]);
    store.account.setCurrentAccount(pubKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context).translationsForLocale().home.accountImport)),
      body: SafeArea(
        child: !_submitting ? _getImportForm() : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }

  Widget _getImportForm() {
    return ImportAccountForm(store, (Map<String, dynamic> data) {
      setState(() {
        _keyType = data['keyType'];
        _cryptoType = data['cryptoType'];
        _derivePath = data['derivePath'];
      });

      if (store.account.isFirstAccount) {
        Navigator.pushNamed(context, CreatePinPage.route, arguments: CreatePinPageParams(_importAccount));
      } else {
        store.account.setNewAccountPin(store.settings.cachedPin);
        _importAccount();
      }
    });
  }
}
