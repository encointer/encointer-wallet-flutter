import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:flutter/cupertino.dart';

import 'package:encointer_wallet/common/components/password_input_dialog.dart' as pass;
import 'package:encointer_wallet/presentation/account/types/account_data.dart';
import 'package:encointer_wallet/store/app_store.dart';

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

  static Future<void> showPasswordInputDialog({
    required BuildContext context,
    required AccountData account,
  }) async {
    final dic = I18n.of(context)!.translationsForLocale();
    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return pass.showPasswordInputDialog(
          context: context,
          account: account,
          title: Text(dic.profile.unlock),
          onOk: (String password) => sl<AppStore>().settings.setPin(password),
        );
      },
    );
  }
}
