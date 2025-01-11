import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/custom/typography/typography_theme.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    this.onPressed,
    this.child,
  });

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
        backgroundColor: colorScheme.surface,
        shadowColor: Colors.black,
        elevation: 3,
        textStyle: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
      ),
      child: child,
    );
  }
}
