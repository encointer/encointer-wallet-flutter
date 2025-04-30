import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/l10.dart';

class CeremonyStartButton extends StatelessWidget {
  const CeremonyStartButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.login_1),
          const SizedBox(width: 6),
          Text(context.l10n.startGathering),
        ],
      ),
    );
  }
}
