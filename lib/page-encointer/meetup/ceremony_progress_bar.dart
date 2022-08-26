import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';

class CeremonyProgressBar extends StatelessWidget {
  final int progress;

  const CeremonyProgressBar({
    required this.progress,
    Key? key,
  }) : super(key: key);

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
  const LightShadedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ZurichLion.shade50, borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: const SizedBox(
        height: 5,
      ),
    );
  }
}

class GradientBar extends StatelessWidget {
  const GradientBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        gradient: primaryGradient,
      ),
      child: const SizedBox(
        height: 5,
      ),
    );
  }
}
