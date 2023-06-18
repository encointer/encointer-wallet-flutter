import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';

class BusinessDetailTextWidget extends StatelessWidget {
  const BusinessDetailTextWidget({
    required this.text,
    required this.text1,
    required this.text2,
    super.key,
  });
  final String text;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$text\n',
              style: context.textTheme.titleLarge!.copyWith(color: context.colorScheme.primary, fontSize: 18),
            ),
            TextSpan(
              text: '$text1\n',
              style: context.textTheme.bodyMedium!.copyWith(height: 1.4),
            ),
            TextSpan(
              text: '$text2\n',
              style: context.textTheme.bodyMedium!.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
