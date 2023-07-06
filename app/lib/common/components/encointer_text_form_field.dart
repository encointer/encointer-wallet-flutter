import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:encointer_wallet/theme/theme.dart';

/// TextFormField styled for the encointer app
class EncointerTextFormField extends StatelessWidget {
  const EncointerTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.textStyle,
    this.inputFormatters,
    this.controller,
    this.textFormFieldKey,
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.fillColor,
    this.filled,
    this.borderRadius = 4,
  });

  final String? labelText;
  final String? hintText;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Key? textFormFieldKey;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Color? fillColor;
  final bool? filled;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextFormField(
        key: textFormFieldKey,
        style: textStyle,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          fillColor: fillColor,
          filled: filled,
          labelStyle: context.titleMedium.copyWith(color: context.colorScheme.primary),
          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 25),
          suffixIcon: suffixIcon,
          border: UnderlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
        ),
        inputFormatters: inputFormatters,
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
      ),
    );
  }
}
