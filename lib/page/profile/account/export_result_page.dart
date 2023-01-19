import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translation/translation.dart';

import 'package:encointer_wallet/store/account/account.dart';

class ExportResultPage extends StatelessWidget {
  const ExportResultPage({super.key});

  static const String route = '/account/key';

  void _showExportDialog(BuildContext context, Map args) {
    Clipboard.setData(ClipboardData(
      text: args['key'] as String,
    ));
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(context.dic.profile.export),
          content: Text(context.dic.profile.exportMnemonicOk),
          actions: <Widget>[
            CupertinoButton(
              child: Text(context.dic.home.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments! as Map<dynamic, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(context.dic.profile.export)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  if (args['type'] != AccountStore.seedTypeKeystore) Text(context.dic.profile.exportWarn),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _showExportDialog(context, args),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            context.dic.home.copy,
                            style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      args['key'] as String,
                      key: const Key('account-mnemonic-key'),
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
