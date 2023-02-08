import 'package:flutter/material.dart';

class PinDots extends StatelessWidget {
  const PinDots(
    this.itemLength, {
    super.key,
    this.maxLengt = 4,
  });

  final int itemLength;
  final int maxLengt;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 25,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: List.generate(maxLengt, (i) {
          final active = itemLength > i;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: CircleAvatar(
                radius: active ? 8 : 5,
                backgroundColor: active ? colorScheme.secondaryContainer : colorScheme.background,
              ),
            ),
          );
        }),
      ),
    );
  }
}
