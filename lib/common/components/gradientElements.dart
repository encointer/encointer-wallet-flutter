import 'package:flutter/material.dart';
import 'package:encointer_wallet/common/theme.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const PrimaryButton(
    this.text,
    this.onPressed, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: encointerGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16), // make splash animation as high as the container
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class TextGradient extends StatelessWidget {
  final String text;
  const TextGradient(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => encointerGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: TextStyle(fontSize: 60)),
    );
  }
}
