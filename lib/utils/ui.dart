import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:translation/translation.dart';

import 'package:encointer_wallet/common/reg_input_formatter.dart';
import 'package:encointer_wallet/config/consts.dart';

class UI {
  static void copyAndNotify(BuildContext context, String? text) {
    Clipboard.setData(ClipboardData(text: text ?? ''));

    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Container(),
          content: Text('${context.dic.assets.copy} ${context.dic.assets.success}'),
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
