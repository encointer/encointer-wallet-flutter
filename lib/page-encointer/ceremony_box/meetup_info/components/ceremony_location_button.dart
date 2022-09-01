import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CeremonyLocationButton extends StatelessWidget {
  const CeremonyLocationButton({
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Future<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context)!.translationsForLocale();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        // make splash animation as high as the container
        primary: Colors.white,
        onPrimary: ZurichLion.shade500,
        shadowColor: ZurichLion.shade500,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Iconsax.location),
          const SizedBox(width: 6),
          Text('${dic.encointer.showCeremonyLocation}'),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
