import 'package:flutter/material.dart';

import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/utils/alerts/app_alert.dart';
import 'package:encointer_wallet/l10.dart';

mixin HandleNewAccountResultMixin on Widget {
  Future<void> navigate({
    required BuildContext context,
    required NewAccountResultType type,
    required void Function() onOk,
    void Function()? onDuplicateAccount,
  }) async {
    return switch (type) {
      NewAccountResultType.ok => onOk(),
      NewAccountResultType.error => AppAlert.showErrorDialog(
          context,
          errorText: context.l10n.createError,
          buttontext: context.l10n.ok,
        ),
      NewAccountResultType.duplicateAccount => onDuplicateAccount != null ? onDuplicateAccount() : null,
    };
  }
}
