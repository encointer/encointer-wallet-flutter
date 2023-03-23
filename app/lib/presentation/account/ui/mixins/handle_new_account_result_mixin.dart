import 'package:encointer_wallet/presentation/account/types/new_account_result.dart';
import 'package:encointer_wallet/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/store/app_store.dart';
import 'package:encointer_wallet/extras/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

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
        final appStore = sl<AppStore>();
        await AppAlert.showPasswordInputDialog(context: context, account: appStore.account.currentAccount);
        break;
      case NewAccountResultType.duplicateAccount:
        if (onDuplicateAccount != null) onDuplicateAccount();
        break;
    }
  }
}
