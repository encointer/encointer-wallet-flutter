import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class CeremonyStartButton extends StatelessWidget {
  const CeremonyStartButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    // var dic = I18n.of(context).translationsForLocale(); // TODO should be this, delete next line
    Translations dic = TranslationsDe();
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
              '${dic.encointer.startCeremony} (count down)', // TODO count down
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
