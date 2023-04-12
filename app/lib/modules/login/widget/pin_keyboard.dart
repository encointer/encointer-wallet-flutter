import 'package:flutter/material.dart';

import 'package:encointer_wallet/common/components/buttons/circle_button.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';

class PinKeyboard extends StatelessWidget {
  const PinKeyboard({
    super.key,
    required this.useLocalAuth,
    required this.onTapDigit,
    required this.removeLastDigit,
  });

  final VoidCallback useLocalAuth;
  final void Function(int value) onTapDigit;
  final VoidCallback removeLastDigit;

  @override
  Widget build(BuildContext context) {
    return CustomGridViewCount(
      children: List.generate(9, (i) {
        return CircleButton(
          child: Text('${i + 1}'),
          onPressed: () => onTapDigit(i + 1),
        );
      })
        ..addAll(
          [
            CircleButton(
              onPressed: useLocalAuth,
              child: const Icon(Icons.fingerprint),
            ),
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
