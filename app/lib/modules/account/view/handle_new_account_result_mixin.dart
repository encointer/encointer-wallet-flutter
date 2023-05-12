import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

mixin HandleNewAccountResultMixin on Widget {
  Future<void> navigate({
    required BuildContext context,
    required NewAccountResultType type,
    required void Function() onOk,
    void Function()? onDuplicateAccount,
  }) async {
    switch (type) {
      case NewAccountResultType.ok:
        onOk();
        break;
      case NewAccountResultType.error:
        final dic = I18n.of(context)!.translationsForLocale();
        AppAlert.showErrorDialog(context, errorText: dic.account.createError, buttontext: dic.home.ok);
        break;
      case NewAccountResultType.emptyPassword:
        final appStore = context.read<AppStore>();
        await AppAlert.showPasswordInputDialog(context, account: appStore.account.currentAccount);
        break;
      case NewAccountResultType.duplicateAccount:
        if (onDuplicateAccount != null) onDuplicateAccount();
        break;
    }
  }
}
