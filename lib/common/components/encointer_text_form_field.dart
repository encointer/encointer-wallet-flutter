import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TextFormField styled for the encointer app
class EncointerTextFormField extends StatelessWidget {
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
  final int? maxLines;
  final int? minLines;
  final bool expands;

  const EncointerTextFormField({
    Key? key,
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
    this.maxLines,
    this.minLines,
    this.expands = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ZurichLion.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        key: textFormFieldKey,
        style: textStyle,
        autofocus: true,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: Theme.of(context).textTheme.headline4,
          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, left: 16),
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
