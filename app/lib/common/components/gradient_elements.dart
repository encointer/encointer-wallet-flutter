import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/theme.dart';

class TextGradient extends StatelessWidget {
  const TextGradient({required this.text, this.style, super.key});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => primaryGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
