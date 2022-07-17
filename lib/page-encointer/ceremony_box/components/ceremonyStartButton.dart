import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CeremonyStartButton extends StatelessWidget {
  const CeremonyStartButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context)!.translationsForLocale();
    return PrimaryButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.login_1),
          SizedBox(width: 6),
          Text('${dic.encointer.startCeremony}'),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
