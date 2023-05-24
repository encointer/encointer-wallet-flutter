import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close, color: encointerGrey),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
