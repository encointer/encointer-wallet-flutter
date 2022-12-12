import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyStartButton extends StatelessWidget {
  const CeremonyStartButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return PrimaryButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.login_1),
          const SizedBox(width: 6),
          Text(dic.encointer.startGathering),
        ],
      ),
    );
  }
}
