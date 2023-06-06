import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

class LowerCeremonyBoxContainer extends StatelessWidget {
  const LowerCeremonyBoxContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
        color: context.colorScheme.background,
      ),
      child: child,
    );
  }
}
