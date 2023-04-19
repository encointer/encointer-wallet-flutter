import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

class CeremonyProgressBar extends StatelessWidget {
  const CeremonyProgressBar({required this.progress, super.key});

  final int progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: progress >= 1 ? const GradientBar() : const LightShadedBar(),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: progress >= 2 ? const GradientBar() : const LightShadedBar(),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: progress >= 3 ? const GradientBar() : const LightShadedBar(),
        ),
      ],
    );
  }
}

class LightShadedBar extends StatelessWidget {
  const LightShadedBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: const SizedBox(height: 5),
    );
  }
}

class GradientBar extends StatelessWidget {
  const GradientBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        gradient: AppColors.primaryGradient,
      ),
      child: const SizedBox(height: 5),
    );
  }
}
