import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:encointer_wallet/common/reg_input_formatter.dart';
import 'package:encointer_wallet/common/constants/consts.dart';
import 'package:encointer_wallet/extras/utils/translations/translations_services.dart';

class UI {
  static void copyAndNotify(BuildContext context, String? text) {
    Clipboard.setData(ClipboardData(text: text ?? ''));

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final dic = I18n.of(context)!.translationsForLocale();
        return CupertinoAlertDialog(
          title: Container(),
          content: Text('${dic.assets.copy} ${dic.assets.success}'),
        );
      },
    );

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  static TextInputFormatter decimalInputFormatter({int decimals = encointerCurrenciesDecimals}) {
    return RegExInputFormatter.withRegex('^[0-9]{0,$decimals}(\\.[0-9]{0,$decimals})?\$');
  }
}
