import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';

class InputValidation {
  static String? validateAccountName(BuildContext context, String? input, List<AccountData> existingAccounts) {
    final dic = context.l10n;

    if (input == null) return dic.contactNameError;

    final name = input.trim();
    if (name.isEmpty) return dic.contactNameError;

    final exist = existingAccounts.indexWhere((i) => i.name == name);
    if (exist > -1) return dic.contactNameAlreadyExists;

    return null;
  }
}
