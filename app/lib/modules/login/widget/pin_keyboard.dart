import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/buttons/circle_button.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';

class PinKeyboard extends StatelessWidget {
  const PinKeyboard({
    super.key,
    required this.onTapDigit,
    required this.removeLastDigit,
    required this.biometricWidget,
  });

  final void Function(int value) onTapDigit;
  final VoidCallback removeLastDigit;
  final Widget biometricWidget;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomGridViewCount(
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: size.aspectRatio * 1.8,
      children: List.generate(9, (i) {
        return CircleButton(
          child: Text('${i + 1}'),
          onPressed: () => onTapDigit(i + 1),
        );
      })
        ..addAll(
          [
            biometricWidget,
            CircleButton(
              child: const Text('0'),
              onPressed: () => onTapDigit(0),
            ),
            CircleButton(
              onPressed: removeLastDigit,
              child: const Icon(Icons.backspace),
            ),
          ],
        ),
    );
  }
}
