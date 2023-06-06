import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/translations/index.dart';

class TransactionsEmpty extends StatelessWidget {
  const TransactionsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale().home;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.swap_vert_sharp, size: 50),
          const SizedBox(height: 25),
          Text(
            dic.noTransactions,
            style: textTheme.displayMedium!.copyWith(color: AppColors.encointerGrey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
