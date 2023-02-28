import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:flutter/material.dart';

class PinInfo extends StatelessWidget {
  const PinInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outlined),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              dic.profile.pinInfo,
              maxLines: 7,
              textAlign: TextAlign.justify,
              softWrap: true,
              style: textTheme.headlineMedium!.copyWith(color: encointerGrey),
            ),
          ),
        ],
      ),
    );
  }
}
