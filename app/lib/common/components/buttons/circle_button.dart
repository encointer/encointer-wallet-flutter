import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.onPressed,
    this.child,
  });

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
          backgroundColor: colorScheme.background,
          shadowColor: Colors.black,
          elevation: 3,
          textStyle: textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 34),
        ),
        child: child,
      ),
    );
  }
}
