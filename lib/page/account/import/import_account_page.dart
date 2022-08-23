import 'package:encointer_wallet/page/account/create/create_pin_page.dart';
import 'package:encointer_wallet/page/account/import/import_account_form.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportAccountPage extends StatefulWidget {
  const ImportAccountPage();

  static const String route = '/account/import';

  @override
  _ImportAccountPageState createState() => _ImportAccountPageState();
}

class _ImportAccountPageState extends State<ImportAccountPage> {
  String? _keyType = '';
  String? _cryptoType = '';
  String? _derivePath = '';
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
          title: Text(I18n.of(context)!.translationsForLocale().home.loading),
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
    _log("imported account to JS.");

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
            title: Container(),
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
      return;
    }
    await _checkAccountDuplicate(acc);
    return;
  }

  Future<void> _checkAccountDuplicate(Map<String, dynamic> acc) async {
    int index = context.read<AppStore>().account.accountList.indexWhere((i) => i.pubKey == acc['pubKey']);
    if (index > -1) {
      Map<String, String> pubKeyMap = context.read<AppStore>().account.pubKeyAddressMap[context.read<AppStore>().settings.endpoint.ss58]!;
      String? address = pubKeyMap[acc['pubKey']];
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
                    await _saveAccount(acc);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      return _saveAccount(acc);
    }
  }

  Future<void> _saveAccount(Map<String, dynamic> acc) async {
    _log("Saving account: ${acc["pubKey"]}");
    var addresses = await webApi.account.encodeAddress([acc['pubKey']]);
    await context.read<AppStore>().addAccount(acc, context.read<AppStore>().account.newAccount.password, addresses[0]);

    String? pubKey = acc['pubKey'];
    await context.read<AppStore>().setCurrentAccount(pubKey);

    await context.read<AppStore>().loadAccountCache();

    // fetch info for the imported account
    webApi.fetchAccountData();
    webApi.account.getPubKeyIcons([pubKey]);

    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context)!.translationsForLocale().home.accountImport)),
      body: SafeArea(
        child: !_submitting ? _getImportForm() : Center(child: CupertinoActivityIndicator()),
      ),
    );
  }

  Widget _getImportForm() {
    return ImportAccountForm(context.read<AppStore>(), (Map<String, dynamic> data) async {
      setState(() {
        _keyType = data['keyType'];
        _cryptoType = data['cryptoType'];
        _derivePath = data['derivePath'];
      });

      if (context.read<AppStore>().account.isFirstAccount) {
        Navigator.pushNamed(context, CreatePinPage.route, arguments: CreatePinPageParams(_importAccount));
      } else {
        context.read<AppStore>().account.setNewAccountPin(context.read<AppStore>().settings.cachedPin);
        await _importAccount();
        Navigator.popUntil(context, ModalRoute.withName('/'));
      }
    });
  }
}

_log(String msg) {
  print("[importAccountPage] $msg");
}
