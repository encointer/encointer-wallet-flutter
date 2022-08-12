import 'dart:convert';

import 'package:encointer_wallet/page/profile/account/exportResultPage.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/accountData.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ExportAccountPage extends StatelessWidget {
  ExportAccountPage({Key? key}) : super(key: key);

  static const String route = '/profile/export';

  final _passCtrl = TextEditingController();

  void _showPasswordDialog(BuildContext context, String seedType, AccountStore store) {
    final dic = I18n.of(context)!.translationsForLocale();

    Future<void> onOk() async {
      var res = await webApi.account.checkAccountPassword(store.currentAccount, _passCtrl.text);
      if (res == null) {
        showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic.profile.wrongPin),
              content: Text(dic.profile.wrongPinHint),
              actions: [
                CupertinoButton(
                  child: Text(I18n.of(context)!.translationsForLocale().home.ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.of(context).pop();
        final seed = await store.decryptSeed(
          store.currentAccount.pubKey,
          seedType,
          _passCtrl.text.trim(),
        );
        Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
          'key': seed!,
          'type': seedType,
        });
      }
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.profile.confirmPin),
          content: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CupertinoTextFormFieldRow(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              padding: EdgeInsets.zero,
              keyboardType: TextInputType.number,
              placeholder: dic.profile.passOld,
              controller: _passCtrl,
              // clearButtonMode: OverlayVisibilityMode.editing,
              validator: (v) {
                if (v == null || !Fmt.checkPassword(v.trim())) {
                  return dic.account.createPasswordError;
                }
                return null;
              },
              obscureText: true,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          actions: [
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.cancel),
              onPressed: () {
                Navigator.of(context).pop();
                _passCtrl.clear();
              },
            ),
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: onOk,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.read<AccountStore>();
    return Scaffold(
      appBar: AppBar(title: Text(dic.profile.export)),
      body: ListView(
        children: [
          ListTile(
            title: Text(dic.account.keystore),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              final json = AccountData.toJson(store.currentAccount);
              json.remove('name');
              json['meta']['name'] = store.currentAccount.name;
              Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
                'key': jsonEncode(json),
                'type': AccountStore.seedTypeKeystore,
              });
            },
          ),
          FutureBuilder(
            future: store.checkSeedExist(AccountStore.seedTypeMnemonic, store.currentAccount.pubKey),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return ListTile(
                  title: Text(dic.account.mnemonic),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () => _showPasswordDialog(context, AccountStore.seedTypeMnemonic, store),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          FutureBuilder(
            future:
                context.read<AccountStore>().checkSeedExist(AccountStore.seedTypeRawSeed, store.currentAccount.pubKey),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return ListTile(
                  title: Text(dic.account.rawSeed),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () => _showPasswordDialog(context, AccountStore.seedTypeRawSeed, store),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
