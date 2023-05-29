import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class PinInfo extends StatelessWidget {
  const PinInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
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
              style: context.textTheme.headlineMedium!.copyWith(color: AppColors.encointerGrey),
            ),
          ),
        ],
      ),
    );
  }
}
