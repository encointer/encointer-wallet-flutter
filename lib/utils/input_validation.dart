import 'package:encointer_wallet/store/account/types/account_data.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

class InputValidation {
  static String? validateAccountName(
      BuildContext context, String? input, List<AccountData> existingAccounts) {
    final dic = I18n.of(context)!.translationsForLocale();

    if (input == null) {
      return dic.profile.contactNameError;
    }

    String name = input.trim();
    if (name.length == 0) {
      return dic.profile.contactNameError;
    }
    int exist = existingAccounts.indexWhere((i) => i.name == name);
    if (exist > -1) {
      return dic.profile.contactNameAlreadyExists;
    }
    return null;
  }
}
