import 'package:encointer_wallet/common/components/gradientElements.dart';
import 'package:encointer_wallet/common/components/maybeDateTime.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CeremonyRegisterButton extends StatefulWidget {
  const CeremonyRegisterButton({
    Key? key,
    this.registerUntil,
    this.onPressed,
  }) : super(key: key);

  final int? registerUntil;
  final Future<void> Function(BuildContext)? onPressed;

  @override
  _CeremonyRegisterButtonState createState() => _CeremonyRegisterButtonState();
}

class _CeremonyRegisterButtonState extends State<CeremonyRegisterButton> {
  bool _submitting = false;

  Future<void> _onPressed() async {
    setState(() {
      _submitting = true;
    });
    await widget.onPressed!(context);
    setState(() {
      _submitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    var dic = I18n.of(context)!.translationsForLocale();

    return PrimaryButton(
      child: !_submitting
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.login_1),
                SizedBox(width: 6),
                Text('${dic.encointer.registerUntil} '),
                MaybeDateTime(widget.registerUntil, dateFormat: DateFormat.yMd(languageCode).add_Hm())
              ],
            )
          : Theme(
              // change theme locally to dark such that the activity indicator appears bright
              data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
              child: CupertinoActivityIndicator()),
      onPressed: !_submitting && widget.registerUntil != null ? () => _onPressed() : null,
    );
  }
}
