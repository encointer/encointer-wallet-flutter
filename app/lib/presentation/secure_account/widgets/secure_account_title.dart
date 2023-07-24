import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';

class SecureAccountTitle extends StatelessWidget {
  const SecureAccountTitle({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.displaySmall!.copyWith(
        color: context.colorScheme.primary,
      ),
    );
  }
}
