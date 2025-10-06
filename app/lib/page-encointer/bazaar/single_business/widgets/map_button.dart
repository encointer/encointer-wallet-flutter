import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:ew_l10n/l10n.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
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
          context.l10n.openMapApplication,
          style: context.bodyLarge.copyWith(color: context.colorScheme.primary),
        ),
      ),
    );
  }
}
