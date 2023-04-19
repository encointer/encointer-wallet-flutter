import 'package:flutter/material.dart';
import 'package:encointer_wallet/theme/theme.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close, color: AppColors.encointerGrey),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
