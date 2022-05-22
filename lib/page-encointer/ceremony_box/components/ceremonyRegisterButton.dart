import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/maybeDateTime.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CeremonyRegisterButton extends StatelessWidget {
  const CeremonyRegisterButton({
    Key key,
    this.languageCode,
    this.registerUntil,
    this.onPressed,
  }) : super(key: key);

  final String languageCode;
  final int registerUntil;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context).translationsForLocale();
    return PrimaryButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.login_1),
          SizedBox(width: 6),
          Text('${dic.encointer.registerUntil} '),
          MaybeDateTime(registerUntil, dateFormat: DateFormat.yMd(languageCode))
        ],
      ),
      onPressed: onPressed,
    );
  }
}
