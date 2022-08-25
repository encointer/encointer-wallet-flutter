import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class ExportResultPage extends StatelessWidget {
  static const String route = '/account/key';

  ExportResultPage({Key? key}) : super(key: key);

  void _showExportDialog(BuildContext context, Map args) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    Clipboard.setData(ClipboardData(
      text: args['key'],
    ));
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.profile.export),
          content: Text(dic.profile.exportMnemonicOk),
          actions: <Widget>[
            CupertinoButton(
              child: Text(I18n.of(context)!.translationsForLocale().home.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    final Map args = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(dic.profile.export)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  args['type'] == AccountStore.seedTypeKeystore ? Container() : Text(dic.profile.exportWarn),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            I18n.of(context)!.translationsForLocale().home.copy,
                            style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                          ),
                        ),
                        onTap: () => _showExportDialog(context, args),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black12,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(Radius.circular(4))),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      args['key'],
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
