import 'package:flutter/cupertino.dart';

class AppAlert {
  static void showErrorCreatingAccountDialog(
    BuildContext context, {
    Widget? title,
    required String errorText,
    required String buttontext,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: Text(errorText),
          actions: <Widget>[
            CupertinoButton(
              child: Text(buttontext),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
