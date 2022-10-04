import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    this.validator,
    this.onChanged,
    this.maxLines,
  }) : super(key: key);

  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final int? maxLines;

  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        autofocus: true,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
