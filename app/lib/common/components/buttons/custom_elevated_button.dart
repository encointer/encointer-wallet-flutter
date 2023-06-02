import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.label,
  });

// final Key? key;
  final VoidCallback? onPressed;
  final Widget icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 16, 5, 16),
        child: Column(
          children: [
            icon,
            const SizedBox(height: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
