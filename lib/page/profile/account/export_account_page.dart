import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page/profile/account/export_result_page.dart';
import 'package:encointer_wallet/service/substrate_api/api.dart';
import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/format.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class ExportAccountPage extends StatelessWidget {
  ExportAccountPage({super.key});

  static const String route = '/profile/export';

  final TextEditingController _passCtrl = TextEditingController();

  void _showPasswordDialog(BuildContext context, String seedType) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.read<AppStore>();

    Future<void> onOk() async {
      final res = await webApi.account.checkAccountPassword(
        store.account.currentAccount,
        _passCtrl.text,
      );
      if (res == null) {
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text(dic.profile.wrongPin),
              content: Text(dic.profile.wrongPinHint),
              actions: <Widget>[
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
        final seed =
            await store.account.decryptSeed(store.account.currentAccount.pubKey, seedType, _passCtrl.text.trim());
        Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
          'key': seed!,
          'type': seedType,
        });
      }
    }

    showCupertinoDialog<void>(
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
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.cancel),
              onPressed: () {
                Navigator.of(context).pop();
                _passCtrl.clear();
              },
            ),
            CupertinoButton(
              onPressed: onOk,
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final store = context.watch<AppStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic.profile.export),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(dic.account.keystore),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              final json = AccountData.toJson(context.read<AppStore>().account.currentAccount)..remove('name');
              json['meta']['name'] = context.read<AppStore>().account.currentAccount.name;
              Navigator.of(context).pushNamed(ExportResultPage.route, arguments: {
                'key': jsonEncode(json),
                'type': AccountStore.seedTypeKeystore,
              });
            },
          ),
          FutureBuilder(
            future: store.account.checkSeedExist(
              AccountStore.seedTypeMnemonic,
              store.account.currentAccount.pubKey,
            ),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return ListTile(
                  title: Text(dic.account.mnemonic),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () => _showPasswordDialog(context, AccountStore.seedTypeMnemonic),
                );
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder(
            future: store.account.checkSeedExist(
              AccountStore.seedTypeRawSeed,
              store.account.currentAccount.pubKey,
            ),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return ListTile(
                  title: Text(dic.account.rawSeed),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () => _showPasswordDialog(context, AccountStore.seedTypeRawSeed),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
