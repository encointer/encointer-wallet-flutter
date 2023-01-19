import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:translation/translation.dart';

class WillPopScopeWrapper extends StatelessWidget {
  const WillPopScopeWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () {
        return Platform.isAndroid
            ? showCupertinoDialog<bool>(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text(context.dic.home.exitConfirm),
                  actions: <Widget>[
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(context.dic.home.cancel),
                    ),
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(context.dic.home.ok),
                    ),
                  ],
                ),
              ).then((value) => value!)
            : Future.value(true);
      },
    );
  }
}
