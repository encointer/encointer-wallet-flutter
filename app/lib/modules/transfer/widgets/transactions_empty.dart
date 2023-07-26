import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/l10n/l10.dart';

class TransactionsEmpty extends StatelessWidget {
  const TransactionsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.swap_vert_sharp, size: 50),
          const SizedBox(height: 25),
          Text(
            context.l10n.noTransactions,
            style: context.titleLarge.copyWith(color: AppColors.encointerGrey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
