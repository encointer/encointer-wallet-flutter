import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/utils/translations/index.dart';

class WillPopScopeWrapper extends StatelessWidget {
  WillPopScopeWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();

    return new WillPopScope(
      child: child,
      onWillPop: () {
        return Platform.isAndroid
            ? showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text(dic.home.exitConfirm),
                  actions: <Widget>[
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(dic.home.cancel),
                    ),
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(dic.home.ok),
                    ),
                  ],
                ),
              ).then((value) => value as bool)
            : Future.value(true);
      },
    );
  }
}
