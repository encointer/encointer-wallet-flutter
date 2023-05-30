import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/theme/theme.dart';

class CeremonyLocationButton extends StatelessWidget {
  const CeremonyLocationButton({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        // make splash animation as high as the container
        backgroundColor: Colors.white,
        foregroundColor: context.colorScheme.secondary,
        shadowColor: context.colorScheme.secondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.location),
          const SizedBox(width: 6),
          Text(dic.encointer.meetingPoint),
        ],
      ),
    );
  }
}
