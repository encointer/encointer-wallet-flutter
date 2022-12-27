import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

class LowerCeremonyBoxContainer extends StatelessWidget {
  const LowerCeremonyBoxContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(15)),
        color: zurichLion.shade50,
      ),
      child: child,
    );
  }
}
