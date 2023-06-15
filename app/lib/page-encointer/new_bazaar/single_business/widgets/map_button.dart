import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    super.key,
    required this.onPressed,
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
          'Open Map',
          style: context.textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
