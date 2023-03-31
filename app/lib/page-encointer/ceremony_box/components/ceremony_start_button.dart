import 'package:encointer_wallet/design_kit/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/extras/utils/translations/i_18_n.dart';

class CeremonyStartButton extends StatelessWidget {
  const CeremonyStartButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

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
