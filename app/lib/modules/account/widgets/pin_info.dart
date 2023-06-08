import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class PinInfo extends StatelessWidget {
  const PinInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outlined),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              dic.pinInfo,
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
