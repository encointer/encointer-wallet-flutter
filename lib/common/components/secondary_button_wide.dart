import 'package:flutter/material.dart';

class SecondaryButtonWide extends StatelessWidget {
  const SecondaryButtonWide({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
