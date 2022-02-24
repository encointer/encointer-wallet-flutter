import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyRegisterButton extends StatelessWidget {
  const CeremonyRegisterButton({
    Key key,
    this.languageCode,
    this.registerUntilDate,
    this.onPressed,
  }) : super(key: key);

  final String languageCode;
  final DateTime registerUntilDate;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context).translationsForLocale();
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: PrimaryButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.login_1),
            SizedBox(
              width: 6,
            ),
            Text(
              '${dic.encointer.registerUntil} ${DateFormat.yMd(languageCode).format(registerUntilDate)}',
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
