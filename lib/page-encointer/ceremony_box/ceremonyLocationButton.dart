import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

class CeremonyLocationButton extends StatelessWidget {
  const CeremonyLocationButton({
    this.onPressedLocation,
    Key key,
  }) : super(key: key);

  final Function onPressedLocation;

  @override
  Widget build(BuildContext context) {
    // var dic = I18n.of(context).translationsForLocale(); // TODO should be this, delete next line
    Translations dic = TranslationsDe();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
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
          Icon(Iconsax.location),
          SizedBox(
            width: 6,
          ),
          Text('${dic.encointer.showCeremonyLocation}'),
        ],
      ),
      onPressed: onPressedLocation, // TODO show map
    );
  }
}
