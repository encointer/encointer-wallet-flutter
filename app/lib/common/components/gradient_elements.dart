import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';

/// In our UX-app design, we distinguish between "Primary" and "Secondary" Buttons. The former being the visually
/// prominent one, the user is supposed to primarily interact with. The latter being a less important button, which
/// offers further options.
///
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.child,
    this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16), // make splash animation as high as the container
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: child,
      ),
    );
  }
}

class TextGradient extends StatelessWidget {
  const TextGradient({required this.text, this.style, super.key});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
