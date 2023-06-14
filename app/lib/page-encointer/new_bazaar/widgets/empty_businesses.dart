import 'package:flutter/material.dart';

import 'package:encointer_wallet/theme/theme.dart';
import 'package:encointer_wallet/utils/utils.dart';

class EmptyBusiness extends StatelessWidget {
  const EmptyBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    final dic = I18n.of(context)!.translationsForLocale();
    return Center(
      child: Text(
        dic.bazaar.noItems,
        style: context.textTheme.displayMedium,
      ),
    );
  }
}
