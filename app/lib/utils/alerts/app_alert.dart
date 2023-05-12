import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/alerts/password_input_dialog.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class AppAlert {
  static Future<T?> showDialog<T>(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget> actions = const <Widget>[],
  }) {
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions,
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context, String title) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: const SizedBox(height: 64, child: CupertinoActivityIndicator()),
        );
      },
    );
  }

  static Future<T?> showConfirmDialog<T>({
    required BuildContext context,
    required VoidCallback onOK,
    required VoidCallback onCancel,
    Widget? title,
    Widget? content,
  }) {
    final dic = I18n.of(context)!.translationsForLocale();
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            CupertinoButton(
              onPressed: onCancel,
              child: Text(dic.home.cancel),
            ),
            CupertinoButton(
              key: const Key('ok-button'),
              onPressed: onOK,
              child: Text(dic.home.ok),
            ),
          ],
        );
      },
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    Widget? title,
    required String errorText,
    required String buttontext,
    void Function()? onPressed,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: Text(errorText),
          actions: <Widget>[
            CupertinoButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: Text(buttontext),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> showPasswordInputDialog(
    BuildContext context, {
    required AccountData account,
    required Future<void> Function(String) onSuccess,
  }) async {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return PasswordInputDialog(account: account, onSuccess: onSuccess);
      },
    );
  }
}
