import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/account/create/create_pin_page.dart';
import 'package:encointer_wallet/page/account/import/import_account_form.dart';
import 'package:encointer_wallet/service/log/log_service.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class ImportAccountPage extends StatefulWidget {
  const ImportAccountPage({Key? key}) : super(key: key);

  static const String route = '/account/import';

  @override
  _ImportAccountPageState createState() => _ImportAccountPageState();
}

class _ImportAccountPageState extends State<ImportAccountPage> {
  String? _keyType = '';
  String? _cryptoType = '';
  String? _derivePath = '';
  bool _submitting = false;

  final _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _importAccount(AppStore store) async {
    setState(() {
      _submitting = true;
    });
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(I18n.of(context)!.translationsForLocale().home.loading),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );

    /// import account
    var acc = await webApi.account.importAccount(
      keyType: _keyType,
      cryptoType: _cryptoType,
      derivePath: _derivePath,
    );
    Log.d("imported account to JS.", 'importAccountPage');

    // check if account duplicate
    if (acc['error'] != null) {
      var msg = acc['error'];

      if (acc['error'] == 'unreachable') {
        msg = "${I18n.of(context)!.translationsForLocale().account.importInvalid}: $_keyType";
      }

      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const SizedBox(),
            content: Text('$msg'),
            actions: <Widget>[
              CupertinoButton(
                child: Text(I18n.of(context)!.translationsForLocale().home.ok),
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
    }
    await _checkAccountDuplicate(acc, store);
  }

  Future<void> _checkAccountDuplicate(Map<String, dynamic> acc, AppStore store) async {
    int index = store.account.accountList.indexWhere((i) => i.pubKey == acc['pubKey']);
    if (index > -1) {
      final pubKeyMap = store.account.pubKeyAddressMap[store.settings.endpoint.ss58]!;
      final address = pubKeyMap[acc['pubKey']];
      if (address != null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(Fmt.address(address)!),
              content: Text(I18n.of(context)!.translationsForLocale().account.importDuplicate),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(I18n.of(context)!.translationsForLocale().home.cancel),
                  onPressed: () {
                    setState(() {
                      _submitting = false;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                  onPressed: () async {
                    await _saveAccount(acc, store);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      _saveAccount(acc, store);
    }
  }

  Future<void> _saveAccount(Map<String, dynamic> acc, AppStore store) async {
    Log.d("Saving account: ${acc["pubKey"]}", 'importAccountPage.dart');
    final addresses = await webApi.account.encodeAddress([acc['pubKey']]);
    await store.addAccount(acc, store.account.newAccount.password, addresses[0]);

    final pubKey = acc['pubKey'];
    await store.setCurrentAccount(pubKey);

    await store.loadAccountCache();

    // fetch info for the imported account
    webApi.fetchAccountData();
    webApi.account.getPubKeyIcons([pubKey]);

    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _store = context.read<AppStore>();
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context)!.translationsForLocale().home.accountImport)),
      body: SafeArea(
        child: !_submitting ? _getImportForm(_store) : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }

  Widget _getImportForm(AppStore store) {
    return ImportAccountForm((Map<String, dynamic> data) async {
      setState(() {
        _keyType = data['keyType'];
        _cryptoType = data['cryptoType'];
        _derivePath = data['derivePath'];
      });

      if (store.account.isFirstAccount) {
        Navigator.pushNamed(context, CreatePinPage.route, arguments: CreatePinPageParams(() => _importAccount(store)));
      } else {
        store.account.setNewAccountPin(store.settings.cachedPin);
        await _importAccount(store);
        Navigator.popUntil(context, ModalRoute.withName('/'));
      }
    });
  }
}
