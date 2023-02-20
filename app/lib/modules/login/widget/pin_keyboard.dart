import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/common/components/buttons/circle_button.dart';
import 'package:encointer_wallet/modules/login/widget/widget.dart';
import 'package:encointer_wallet/modules/modules.dart';

class PinKeyboard extends StatelessWidget {
  const PinKeyboard({super.key, required this.useLocalAuth});
  final VoidCallback useLocalAuth;

  @override
  Widget build(BuildContext context) {
    return CustomGridViewCount(
      children: List.generate(9, (i) {
        return CircleButton(
          child: Text('${i + 1}'),
          onPressed: () => context.read<LoginStore>().addPinCode(i + 1),
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
              onPressed: () => context.read<LoginStore>().addPinCode(0),
            ),
            CircleButton(
              onPressed: context.read<LoginStore>().removeLastDigit,
              child: const Icon(Icons.backspace),
            ),
          ],
        ),
    );
  }
}
