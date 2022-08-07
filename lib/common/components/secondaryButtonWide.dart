import 'package:flutter/material.dart';

class SecondaryButtonWide extends StatelessWidget {
  SecondaryButtonWide({
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
