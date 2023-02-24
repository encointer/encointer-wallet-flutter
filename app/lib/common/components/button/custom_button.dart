import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.backgroundColor = Colors.transparent,
    this.foregroundColor = Colors.white,
    this.shadowColor = Colors.transparent,
    this.textStyle,
    super.key,
  });

  final void Function()? onPressed;
  final String label;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: backgroundColor == null ? primaryGradient : null,
        borderRadius: borderRadius,
        color: backgroundColor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shadowColor: shadowColor,
          textStyle: textStyle,
          fixedSize: Size(size.width * 0.9, double.infinity),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    required this.label,
    required this.icon,
    this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.backgroundColor = Colors.transparent,
    this.foregroundColor = Colors.white,
    this.shadowColor = Colors.transparent,
    this.textStyle,
    super.key,
  });

  final void Function()? onPressed;
  final String label;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? shadowColor;
  final TextStyle? textStyle;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shadowColor: shadowColor,
          textStyle: textStyle,
          fixedSize: Size(size.width * 0.9, double.infinity),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: icon,
        label: Text(label),
      ),
    );
  }
}
