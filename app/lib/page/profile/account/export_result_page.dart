import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:encointer_wallet/store/account/account.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class ExportResultPage extends StatelessWidget {
  const ExportResultPage({super.key});

  static const String route = '/account/key';

  void _showExportDialog(BuildContext context, Map args) {
    final dic = context.l10n;
    Clipboard.setData(ClipboardData(
      text: args['key'] as String,
    ));
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(dic.export),
          content: Text(dic.exportMnemonicOk),
          actions: <Widget>[
            CupertinoButton(
              child: Text(context.l10n.ok),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dic = context.l10n;
    final args = ModalRoute.of(context)!.settings.arguments! as Map<dynamic, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(dic.export)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  if (args['type'] != AccountStore.seedTypeKeystore) Text(dic.exportWarn),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _showExportDialog(context, args),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            dic.copy,
                            style: TextStyle(fontSize: 14, color: context.colorScheme.primary),
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
                      style: context.textTheme.headlineMedium,
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
