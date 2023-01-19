import 'package:flutter/material.dart';
import 'package:translation/translation.dart';

import 'package:encointer_wallet/store/account/types/account_data.dart';

class InputValidation {
  static String? validateAccountName(BuildContext context, String? input, List<AccountData> existingAccounts) {
    if (input == null) {
      return context.dic.profile.contactNameError;
    }

    final name = input.trim();
    if (name.isEmpty) {
      return context.dic.profile.contactNameError;
    }
    final exist = existingAccounts.indexWhere((i) => i.name == name);
    if (exist > -1) {
      return context.dic.profile.contactNameAlreadyExists;
    }
    return null;
  }
}
