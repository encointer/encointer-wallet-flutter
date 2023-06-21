import 'package:flutter/cupertino.dart';

// import 'package:encointer_wallet/store/account/types/account_data.dart';
// import 'package:encointer_wallet/utils/alerts/password_input_dialog.dart';
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
    Key oKButtonKey = const Key('ok-button'),
    Key cancelButtonKey = const Key('cansel-button'),
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

  // static Future<bool?> showPasswordInputDialog(
  //   BuildContext context, {
  //   required AccountData account,
  //   required Future<void> Function(String) onSuccess,
  //   bool canPop = true,
  //   bool showCancelButton = false,
  //   bool autoCloseOnSuccess = true,
  //   String? title,
  // }) async {
  //   return showCupertinoDialog<bool>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return PasswordInputDialog(
  //         title: title,
  //         account: account,
  //         onSuccess: onSuccess,
  //         canPop: canPop,
  //         showCancelButton: showCancelButton,
  //         autoCloseOnSuccess: autoCloseOnSuccess,
  //       );
  //     },
  //   );
  // }
}
