import 'package:encointer_wallet/common/components/password_input_dialog.dart';
import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AppAlert {
  static void showErrorDailog(
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

  static Future<void> showInputPasswordDailog({
    required BuildContext context,
    required AccountData account,
  }) async {
    final dic = I18n.of(context)!.translationsForLocale();
    return showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return showPasswordInputDialog(
          context,
          account,
          Text(dic.profile.unlock),
          (String password) => context.read<AppStore>().settings.setPin(password),
        );
      },
    );
  }
}
