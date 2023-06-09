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
    final dic = I18n.of(context)!.translationsForLocale();
    final appStore = context.read<AppStore>();
    return switch (type) {
      NewAccountResultType.ok => onOk(),
      NewAccountResultType.error => AppAlert.showErrorDialog(
          context,
          errorText: dic.account.createError,
          buttontext: dic.home.ok,
        ),
      NewAccountResultType.emptyPassword => await AppAlert.showPasswordInputDialog(
          context,
          account: appStore.account.currentAccount,
          onSuccess: appStore.settings.setPin,
        ),
      NewAccountResultType.duplicateAccount => onDuplicateAccount != null ? onDuplicateAccount() : null,
    };
  }
}
