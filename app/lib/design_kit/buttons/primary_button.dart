import 'package:encointer_wallet/design_kit/colors/app_colors_config.dart';
import 'package:flutter/material.dart';

/// In our UX-app design, we distinguish between "Primary" and "Secondary" Buttons. The former being the visually
/// prominent one, the user is supposed to primarily interact with. The latter being a less important button, which
/// offers further options.
///
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.child,
    required this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    super.key,
  });

  final Widget child;
  final VoidCallback onPressed;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: appColors.primaryGradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16), // make splash animation as high as the container
          backgroundColor: appColors.transparent,
          foregroundColor: appColors.white,
          shadowColor: appColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: child,
      ),
    );
  }
}
