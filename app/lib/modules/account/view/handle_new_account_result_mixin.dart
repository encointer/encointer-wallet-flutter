import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

mixin HandleNewAccountResultMixin on Widget {
  Future<void> navigate({
    required BuildContext context,
    required AddAccountResponse type,
    required void Function() onOk,
    void Function()? onDuplicate,
  }) async {
    switch (type) {
      case AddAccountResponse.success:
        onOk();
        break;
      case AddAccountResponse.fail:
        final dic = I18n.of(context)!.translationsForLocale();
        AppAlert.showErrorDailog(context, errorText: dic.account.createError, buttontext: dic.home.ok);
        break;
      case AddAccountResponse.passwordEmpty:
        final appStore = context.read<AppStore>();
        await AppAlert.showInputPasswordDailog(context: context, account: appStore.account.currentAccount);
        break;
      case AddAccountResponse.duplicate:
        if (onDuplicate != null) onDuplicate();
        break;
    }
  }
}
