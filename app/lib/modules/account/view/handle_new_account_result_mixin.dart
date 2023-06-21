import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/l10n/l10.dart';

mixin HandleNewAccountResultMixin on Widget {
  Future<void> navigate({
    required BuildContext context,
    required NewAccountResultType type,
    required void Function() onOk,
    void Function()? onDuplicateAccount,
  }) async {
    final appStore = context.read<AppStore>();
    return switch (type) {
      NewAccountResultType.ok => onOk(),
      NewAccountResultType.error => AppAlert.showErrorDialog(
          context,
          errorText: context.l10n.createError,
          buttontext: context.l10n.ok,
        ),
      NewAccountResultType.emptyPassword => await AppAlert.showPasswordInputDialog(
          context,
          account: appStore.account.currentAccount,
          onSuccess: (v) async {
            await context.read<LoginStore>().setPin(v);
            appStore.settings.cachedPin = v;
          },
        ),
      NewAccountResultType.duplicateAccount => onDuplicateAccount != null ? onDuplicateAccount() : null,
    };
  }
}
