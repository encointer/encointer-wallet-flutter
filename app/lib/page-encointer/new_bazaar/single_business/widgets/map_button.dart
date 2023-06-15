import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().home;
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colorScheme.onSecondary,
          padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
          elevation: 7,
        ),
        child: Text(
          dic.openMapApplication,
          style: context.textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
