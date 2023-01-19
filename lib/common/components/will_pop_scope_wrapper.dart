import 'dart:io';

import 'package:ew_translation/translation.dart';
import 'package:flutter/cupertino.dart';

class WillPopScopeWrapper extends StatelessWidget {
  const WillPopScopeWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dic = context.dic;
    return WillPopScope(
      child: child,
      onWillPop: () {
        return Platform.isAndroid
            ? showCupertinoDialog<bool>(
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
              ).then((value) => value!)
            : Future.value(true);
      },
    );
  }
}
