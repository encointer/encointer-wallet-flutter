import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: zurichLion.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        key: textFormFieldKey,
        style: textStyle,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: Theme.of(context).textTheme.headlineMedium,
          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 25),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          suffixIcon: suffixIcon,
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
