import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/l10.dart';
import 'package:flutter/material.dart';

class InputValidation {
  static String? validateAccountName(BuildContext context, String? input, List<AccountData> existingAccounts) {
    final l10n = context.l10n;

    if (input == null) return l10n.contactNameError;

    final name = input.trim();
    if (name.isEmpty) return l10n.contactNameError;

    final exist = existingAccounts.indexWhere((i) => i.name == name);
    if (exist > -1) return l10n.contactNameAlreadyExists;

    return null;
  }
}
