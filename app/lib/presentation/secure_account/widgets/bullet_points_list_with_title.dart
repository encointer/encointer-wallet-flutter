import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';

const _point = '\u2022';

class BulletPointsListWithTitle extends StatelessWidget {
  const BulletPointsListWithTitle({
    required this.title,
    required this.texts,
    this.textStyle,
    super.key,
  });
  final String title;
  final List<String> texts;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: textStyle ??
              context.textTheme.labelLarge!.copyWith(
                color: context.colorScheme.onBackground,
                fontWeight: FontWeight.w600,
              ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: texts.length,
          itemBuilder: (context, index) {
            return _singlePointContent(context, texts[index]);
          },
        ),
      ],
    );
  }

  Widget _singlePointContent(BuildContext context, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _point,
          style: context.textTheme.labelLarge!.copyWith(
            color: context.colorScheme.onBackground,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToLastDescent: false,
            applyHeightToFirstAscent: false,
          ),
        ),
        const SizedBox(width: 3),
        Expanded(
          child: Text(
            value,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToLastDescent: false,
              applyHeightToFirstAscent: false,
            ),
          ),
        ),
      ],
    );
  }
}
