import 'package:ew_test_keys/ew_test_keys.dart';
import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/l10n/l10.dart';

class AppAlert {
  static Future<T?> showDialog<T>(
    BuildContext context, {
    Widget? title,
    Widget? content,
    List<Widget> actions = const <Widget>[],
    bool barrierDismissible = false,
  }) {
    return showCupertinoDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
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
    Key oKButtonKey = const Key(EWTestKeys.okButton),
    Key cancelButtonKey = const Key(EWTestKeys.cancelButton),
    Widget? title,
    Widget? content,
    String? confirmText,
    String? cancelText,
  }) {
    final l10n = context.l10n;
    return showCupertinoDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: content,
          actions: <Widget>[
            CupertinoButton(
              key: cancelButtonKey,
              onPressed: onCancel,
              child: Text(cancelText ?? l10n.cancel),
            ),
            CupertinoButton(
              key: oKButtonKey,
              onPressed: onOK,
              child: Text(confirmText ?? l10n.ok),
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
    TextStyle? textStyle,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: title,
          content: Text(errorText, style: textStyle),
          actions: <Widget>[
            CupertinoButton(
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
              child: Text(buttontext, style: textStyle),
            ),
          ],
        );
      },
    );
  }
}
