import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';

class BusinessDetailTextWidget extends StatelessWidget {
  const BusinessDetailTextWidget({
    super.key,
    required this.text,
    required this.text1,
  });
  final String text;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: text,
                style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.primary, fontSize: 18)),
            TextSpan(text: text1, style: context.textTheme.bodyMedium!.copyWith(height: 1.4)),
          ],
        ),
      ),
    );
  }
}
