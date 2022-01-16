import 'package:clipboard/clipboard.dart';
import 'package:encointer_wallet/common/components/addressIcon.dart';
import 'package:encointer_wallet/common/components/passwordInputDialog.dart';
import 'package:encointer_wallet/page/profile/account/changeNamePage.dart';
import 'package:encointer_wallet/page/profile/account/exportAccountPage.dart';
import 'package:encointer_wallet/service/substrateApi/api.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/i18n/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';

class AccountManagePage extends StatelessWidget {
  AccountManagePage(this.store);

  static final String route = '/profile/account';
  final Api api = webApi;
  final AppStore store;

  void _onDeleteAccount(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return showPasswordInputDialog(
            context, store.account.currentAccount, Text(I18n.of(context).profile['delete.confirm']), (_) {
          store.account.removeAccount(store.account.currentAccount).then((_) {
            // refresh balance
            store.assets.loadAccountCache();
            webApi.assets.fetchBalance();
          });
          Navigator.of(context).pop();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dic = I18n.of(context).profile;

    Color primaryColor = Theme.of(context).primaryColor;
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(store.account.currentAccount.name),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AddressIcon(
                      '',
                      size: 100,
                      pubKey: store.account.currentAccount.pubKey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text(Fmt.address(store.account.currentAddress), style: TextStyle(fontSize: 20)),
                      ElevatedButton(
                        child: Icon(Icons.copy),
                        onPressed: () {
                          final data = ClipboardData(text: store.account.currentAddress);
                          Clipboard.setData(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('✓   Copied to Clipboard')),
                          );
                        },
                      ),],
                    ),
                    // buildCopy(store.account.currentAddress),
                    Text(Fmt.address(store.account.currentAddress) ?? '',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    Container(padding: EdgeInsets.only(top: 16)),
                    ListTile(
                      title: Text(dic['name.change']),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () => Navigator.pushNamed(context, ChangeNamePage.route),
                    ),
                    ListTile(
                      title: Text(dic['export']),
                      trailing: Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () => Navigator.of(context).pushNamed(ExportAccountPage.route),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(color: Colors.red),
                      ),
                      child: Text(dic['delete']),
                      onPressed: () => _onDeleteAccount(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
