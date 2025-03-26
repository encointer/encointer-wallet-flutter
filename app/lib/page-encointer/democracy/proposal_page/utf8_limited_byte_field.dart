import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utf8LimitedTextField extends StatefulWidget {
  const Utf8LimitedTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
    required this.maxBytes,
    this.validator,
    this.minLines = 1,
    this.maxLines = 5,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? labelText;
  final String? errorText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxBytes;
  final int minLines;
  final int maxLines;

  @override
  Utf8LimitedTextFieldState createState() => Utf8LimitedTextFieldState();
}

class Utf8LimitedTextFieldState extends State<Utf8LimitedTextField> {
  int _usedBytes = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateByteCount);
  }

  void _updateByteCount() {
    setState(() {
      _usedBytes = utf8.encode(widget.controller.text).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        counterText: '$_usedBytes/${widget.maxBytes}',
      ),
      validator: widget.validator,
      inputFormatters: [Utf8ByteLimitFormatter(widget.maxBytes)],
      onChanged: (value) {
        widget.onChanged?.call(value);
        _updateByteCount();
      },
      keyboardType: TextInputType.multiline,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateByteCount);
    super.dispose();
  }
}

class Utf8ByteLimitFormatter extends TextInputFormatter {
  Utf8ByteLimitFormatter(this.maxBytes);
  final int maxBytes;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (utf8.encode(newValue.text).length <= maxBytes) {
      return newValue;
    }

    var trimmedText = newValue.text;
    while (utf8.encode(trimmedText).length > maxBytes) {
      trimmedText = trimmedText.substring(0, trimmedText.length - 1);
    }

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: trimmedText.length),
    );
  }
}
