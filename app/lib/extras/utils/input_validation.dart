import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';
import 'package:encointer_wallet/presentation/account/types/account_data.dart';

import 'package:flutter/material.dart';

class InputValidation {
  static String? validateAccountName(BuildContext context, String? input, List<AccountData> existingAccounts) {
    final dic = I18n.of(context)!.translationsForLocale();

    if (input == null) return dic.profile.contactNameError;

    final name = input.trim();
    if (name.isEmpty) return dic.profile.contactNameError;

    final exist = existingAccounts.indexWhere((i) => i.name == name);
    if (exist > -1) return dic.profile.contactNameAlreadyExists;

    return null;
  }
}
