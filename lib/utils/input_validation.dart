import 'package:ew_translation/translation.dart';
import 'package:flutter/material.dart';

import 'package:encointer_wallet/store/account/types/account_data.dart';

class InputValidation {
  static String? validateAccountName(BuildContext context, String? input, List<AccountData> existingAccounts) {
    final dic = context.dic;
    if (input == null) {
      return dic.profile.contactNameError;
    }

    final name = input.trim();
    if (name.isEmpty) {
      return dic.profile.contactNameError;
    }
    final exist = existingAccounts.indexWhere((i) => i.name == name);
    if (exist > -1) {
      return dic.profile.contactNameAlreadyExists;
    }
    return null;
  }
}
