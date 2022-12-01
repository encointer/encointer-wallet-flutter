import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/common/components/maybe_date_time.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class CeremonyRegisterButton extends StatefulWidget {
  const CeremonyRegisterButton({
    Key? key,
    this.registerUntil,
    this.onPressed,
  }) : super(key: key);

  final int? registerUntil;
  final Future<void> Function(BuildContext)? onPressed;

  @override
  State<CeremonyRegisterButton> createState() => _CeremonyRegisterButtonState();
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
          ? FittedBox(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.login_1),
                  const SizedBox(width: 6),
                  Text('${dic.encointer.registerUntil} '),
                  MaybeDateTime(widget.registerUntil, dateFormat: DateFormat.yMd(languageCode).add_Hm())
                ],
              ),
          )
          : Theme(
              // change theme locally to dark such that the activity indicator appears bright
              data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.dark)),
              child: const CupertinoActivityIndicator()),
      onPressed: !_submitting && widget.registerUntil != null ? () => _onPressed() : null,
    );
  }
}
